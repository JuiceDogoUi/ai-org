---
name: deploy
description: Execute deployment workflow
argument-hint: "[environment: staging|production]"
context: fork
agent: eng-devops
disable-model-invocation: true
---

Deploy to: $ARGUMENTS

## Process

1. Verify the build passes and all tests are green
2. Run pre-deployment checks (lint, type checks, security scan)
3. Confirm the target environment with the user before proceeding
4. Run a dry-run first if the deployment tool supports it
5. Execute deployment following project conventions (CI/CD pipeline, manual deploy script, or platform CLI)
6. Verify deployment health (health check endpoints, smoke tests, error rate monitoring)
7. Report deployment status with rollback instructions

## Standards

- Always confirm the target environment before proceeding
- Never deploy to production without passing staging first (if staging exists)
- Verify health checks after deployment
- Report rollback instructions if something fails

## Output

- Pre-deployment check results (build, tests, lint)
- Deployment execution log
- Health check verification results
- Rollback instructions in case of failure

> Related: `/build` to build the feature before deploying, `/review` to review code before deploying, `/audit` to run a security audit before production.
