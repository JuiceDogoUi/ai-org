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

1. Verify the build passes
2. Run pre-deployment checks (tests, lint)
3. Execute deployment following project conventions
4. Verify deployment health
5. Report deployment status

## Safety

- Always confirm the target environment before proceeding
- Run a dry-run if the deployment tool supports it
- Verify health checks after deployment
- Report rollback instructions if something fails
