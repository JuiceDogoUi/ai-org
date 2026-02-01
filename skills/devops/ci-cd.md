# CI/CD Patterns

## Pipeline Structure

### Recommended Stage Order
1. **Checkout & Install** -- clone, restore cache, install dependencies
2. **Lint & Format** -- fast, catches obvious issues early
3. **Unit Tests** -- parallel execution, fail fast
4. **Build** -- compile, bundle, generate artifacts
5. **Integration Tests** -- against real services (database, APIs)
6. **Security Scan** -- dependency audit, SAST
7. **Deploy to Staging** -- automatic on main branch
8. **E2E Tests** -- against staging environment
9. **Deploy to Production** -- manual approval gate or automatic canary

### Speed Optimization
```yaml
# Parallelize independent jobs
jobs:
  lint:
    runs-on: ubuntu-latest
    steps: [checkout, setup-node, lint]

  test:
    runs-on: ubuntu-latest
    steps: [checkout, setup-node, test]

  build:
    runs-on: ubuntu-latest
    needs: [lint, test]  # Wait for parallel jobs
    steps: [checkout, setup-node, build]
```

### Caching
```yaml
# Cache node_modules based on lockfile hash
- uses: actions/cache@v4
  with:
    path: node_modules
    key: node-${{ hashFiles('package-lock.json') }}

# Cache Gradle dependencies
- uses: actions/cache@v4
  with:
    path: |
      ~/.gradle/caches
      ~/.gradle/wrapper
    key: gradle-${{ hashFiles('**/*.gradle*', '**/gradle-wrapper.properties') }}
```

## Deployment Strategies

### Blue-Green
```text
1. Deploy new version to "green" environment
2. Run health checks and smoke tests against green
3. Switch load balancer from blue → green
4. Keep blue running as instant rollback target
5. After validation period, decommission blue
```

### Canary
```text
1. Deploy new version to small subset (5-10% of traffic)
2. Monitor error rates, latency, and business metrics
3. If healthy, gradually increase traffic (25%, 50%, 100%)
4. If degraded, route all traffic back to stable version
```

### Rolling Update
```yaml
# Kubernetes rolling update
spec:
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 25%        # Max pods above desired count
      maxUnavailable: 25%   # Max pods that can be unavailable
```

## Environment Management

### Secrets
- Never store secrets in code or CI config files
- Use CI platform's secret management (GitHub Secrets, GitLab CI Variables)
- Rotate secrets on a schedule
- Use different secrets per environment

### Environment Variables
```bash
# .env.example (committed -- documents required vars)
DATABASE_URL=
API_KEY=
LOG_LEVEL=info

# .env (never committed -- actual values)
DATABASE_URL=postgres://user:pass@localhost:5432/mydb
API_KEY=sk_live_abc123
LOG_LEVEL=debug
```

## Branch Strategy
```text
main ─────────────────────────── production deploys
  └── develop ────────────────── staging deploys
        ├── feature/add-search── PR → develop
        ├── fix/login-bug ────── PR → develop
        └── release/2.1.0 ────── PR → main (with tag)
```

## Monitoring After Deploy
- Watch error rate for 15-30 minutes post-deploy
- Compare latency p50/p95/p99 against pre-deploy baseline
- Monitor business metrics (conversion, signups) for regression
- Set up automatic rollback triggers on error rate thresholds
