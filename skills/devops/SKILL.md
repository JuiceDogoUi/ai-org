---
name: devops
description: CI/CD patterns, containerization, infrastructure as code, and deployment strategies. Use when working with pipelines, containers, or infrastructure.
user-invocable: false
---

# DevOps Conventions

## CI/CD Pipelines

### Pipeline Design
- Keep pipelines fast: parallelize independent jobs
- Fail fast: run linting and unit tests before expensive steps
- Cache dependencies between runs
- Use environment-specific configs (never hardcode secrets)
- Tag releases with semantic versioning

### Pipeline Stages
```yaml
stages:
  - lint        # Fast feedback (seconds)
  - test        # Unit tests (minutes)
  - build       # Compile, bundle
  - security    # SAST, dependency scan
  - deploy-staging
  - integration # E2E tests against staging
  - deploy-prod
```

### Caching
```yaml
# Cache node_modules based on lockfile
cache:
  key: $CI_COMMIT_REF_SLUG-$CI_PROJECT_DIR/package-lock.json
  paths:
    - node_modules/
```

## Docker

### Dockerfile Best Practices
```dockerfile
# Use specific version, not latest
FROM node:20-alpine AS builder

WORKDIR /app

# Copy dependency files first (cache layer)
COPY package*.json ./
RUN npm ci --only=production

# Copy source after dependencies
COPY . .
RUN npm run build

# Production image
FROM node:20-alpine
WORKDIR /app

# Run as non-root
RUN addgroup -g 1001 appgroup && adduser -u 1001 -G appgroup -s /bin/sh -D appuser
USER appuser

COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules

EXPOSE 3000
CMD ["node", "dist/server.js"]
```

### Docker Compose
```yaml
services:
  app:
    build: .
    ports:
      - "3000:3000"
    environment:
      - DATABASE_URL=postgres://db:5432/app
    depends_on:
      db:
        condition: service_healthy
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3000/health"]
      interval: 30s
      timeout: 10s
      retries: 3

  db:
    image: postgres:16-alpine
    volumes:
      - pgdata:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres"]
```

## Infrastructure as Code

### Terraform Patterns
```hcl
# Use modules for reusable infrastructure
module "vpc" {
  source = "./modules/vpc"

  environment = var.environment
  cidr_block  = var.vpc_cidr
}

# Use workspaces or directories for environments
# environments/
#   prod/
#   staging/
#   dev/
```

### IaC Principles
- Version control all infrastructure code
- Use remote state with locking (S3 + DynamoDB, Terraform Cloud)
- Plan before apply, review diffs
- Use modules for reusable patterns
- Tag all resources for cost tracking

## Deployment Strategies

### Blue-Green
- Two identical environments
- Switch traffic at load balancer
- Instant rollback capability
- Double infrastructure cost

### Canary
- Route small percentage to new version
- Monitor error rates and latency
- Gradually increase traffic
- Rollback if metrics degrade

### Rolling
- Update instances incrementally
- Maintain availability during deploy
- Slower rollback (must redeploy previous)

## Kubernetes Essentials

### Resource Definitions
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp
  template:
    spec:
      containers:
        - name: app
          image: myapp:1.2.3
          resources:
            requests:
              memory: "128Mi"
              cpu: "100m"
            limits:
              memory: "256Mi"
              cpu: "500m"
          livenessProbe:
            httpGet:
              path: /health
              port: 3000
            initialDelaySeconds: 10
          readinessProbe:
            httpGet:
              path: /ready
              port: 3000
```

### Key Concepts
- Set resource requests and limits
- Use liveness and readiness probes
- Use ConfigMaps for config, Secrets for sensitive data
- Use namespaces for isolation
- Use HPA for autoscaling

## Monitoring & Observability

### Three Pillars
- **Logs**: Structured JSON, correlation IDs, log levels
- **Metrics**: RED (Rate, Errors, Duration), USE (Utilization, Saturation, Errors)
- **Traces**: Distributed tracing for request flow

### Alerting
- Alert on symptoms (high error rate) not causes (CPU high)
- Set meaningful thresholds, avoid alert fatigue
- Include runbook links in alerts
- Page for user-impacting issues only

## Secrets Management

- Never commit secrets to version control
- Use secrets managers (Vault, AWS Secrets Manager, 1Password)
- Rotate secrets regularly
- Audit secret access
- Inject secrets at runtime, not build time

## Avoid

- **Secrets in code or repos** — Use secrets manager, inject at runtime
- **Manual deployments** — Automate everything; manual = error-prone
- **Snowflake servers** — Infrastructure should be reproducible from code
- **`latest` tags** — Pin versions for reproducibility
- **Skipping health checks** — Required for proper orchestration
- **Running as root** — Use non-root users in containers
- **Ignoring resource limits** — Unbounded containers can crash nodes
- **No rollback plan** — Every deploy needs a revert strategy
- **Alerting on everything** — Alert fatigue leads to ignored alerts
- **SSH into production** — Debug via logs and metrics; immutable infrastructure
