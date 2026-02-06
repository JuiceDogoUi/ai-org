---
name: deploy
description: Deployment workflow
argument-hint: "[environment: staging|production]"
user-invocable: true
context: fork
agent: eng-devops
---

Deploy to: $ARGUMENTS
