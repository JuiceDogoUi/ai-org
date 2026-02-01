---
name: devops
description: CI/CD patterns, Docker configuration, and deployment strategies. Use when working with pipelines, containers, or infrastructure.
user-invocable: false
---

# DevOps Conventions

## CI/CD
- Keep pipelines fast: parallelize independent jobs
- Fail fast: run linting and unit tests before expensive steps
- Cache dependencies between runs
- Use environment-specific configs (never hardcode secrets)
- Tag releases with semantic versioning

## Docker
- Use multi-stage builds to minimize image size
- Pin base image versions (not `latest`)
- Run as non-root user
- Use `.dockerignore` to exclude unnecessary files
- Order Dockerfile layers for cache efficiency (dependencies before code)

## Deployment
- Use blue-green or canary deployments for zero downtime
- Implement health checks for readiness and liveness
- Use rollback procedures for failed deployments
- Monitor error rates post-deploy

For Docker patterns, see [docker.md](docker.md).
For CI/CD patterns, see [ci-cd.md](ci-cd.md).
