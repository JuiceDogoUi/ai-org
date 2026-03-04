---
name: devops
description: CI/CD patterns, containerization, infrastructure as code, and deployment strategies. Use when working with pipelines, containers, or infrastructure.
user-invocable: false
---

# DevOps Conventions

> **Documentation Freshness**: DevOps tooling evolves rapidly. Always check official
> docs for Terraform (developer.hashicorp.com), Kubernetes (kubernetes.io), Docker
> (docs.docker.com), and your CI platform for current syntax and best practices.

## File Guide
- **ci-cd.md** — Pipeline structure, caching, deployment strategies, environment management
- **docker.md** — Multi-stage builds, Docker Compose for development, .dockerignore

## CI/CD Pipelines

- Keep pipelines fast: parallelize independent jobs, fail fast
- Cache dependencies between runs
- Tag releases with semantic versioning

See **ci-cd.md** for pipeline structure, caching patterns, deployment strategies, and environment management.

## Docker

- Use multi-stage builds to minimize image size
- Pin base image versions (not `latest`)
- Run as non-root user
- Order layers for cache efficiency (dependencies before source)

See **docker.md** for Dockerfile patterns, Compose configuration, and .dockerignore.

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

Choose based on risk tolerance and infrastructure: Blue-Green (instant rollback), Canary (gradual traffic shift), or Rolling (incremental update). See **ci-cd.md** for detailed patterns.

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
