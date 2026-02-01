---
name: refactor
description: Refactor code with pre and post review
argument-hint: "[target and refactoring goal]"
context: fork
agent: orchestrator
---

Refactor: $ARGUMENTS

## Workflow

1. **Pre-review**: reviewer-code agent analyzes current state and identifies issues
2. **Refactor**: Appropriate engineering agent performs the refactoring
3. **Post-review**: reviewer-code agent validates the result
4. **Verify**: eng-testing agent confirms tests still pass

## Rules

- Preserve all existing behavior unless explicitly told otherwise
- Run tests before and after to verify no regressions
- Keep the refactoring focused on the stated goal
- Do not add features or change behavior during refactoring
