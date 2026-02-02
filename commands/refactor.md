---
name: refactor
description: Refactor code with pre and post review
argument-hint: "[target and refactoring goal]"
context: fork
agent: orchestrator
---

Refactor: $ARGUMENTS

## Process

1. **Pre-review**: reviewer-code agent analyzes current state and identifies issues
2. **Refactor**: Orchestrator selects the appropriate engineering agent based on the code being refactored:
   - eng-frontend → UI components, pages, client-side logic
   - eng-backend → services, business logic, data access, queries, schema, migrations
   - eng-api → API endpoints, route handlers, request/response
   - eng-styles → CSS, styling, design tokens
   - If the specific agent is not available, delegate to the closest available engineering agent
3. **Post-review**: reviewer-code agent validates the result
4. **Verify**: eng-testing agent confirms tests still pass

## Standards

- Preserve all existing behavior unless explicitly told otherwise
- Run tests before and after to verify no regressions
- Keep the refactoring focused on the stated goal
- Do not add features or change behavior during refactoring

## Output

- Refactored code with all tests passing
- Pre-review findings (what was wrong before)
- Post-review confirmation (what improved and any remaining concerns)
- Test results confirming no regressions

> Related: `/review` for a standalone code review, `/test` to add missing test coverage before refactoring.
