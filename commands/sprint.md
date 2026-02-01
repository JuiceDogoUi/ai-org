---
name: sprint
description: Sprint planning and task breakdown
argument-hint: "[sprint goals or backlog items]"
context: fork
agent: project-manager
---

Plan sprint with goals: $ARGUMENTS

## Process

1. Break down goals into concrete tasks
2. Estimate each task (S/M/L)
3. Identify dependencies between tasks
4. Suggest task ordering based on dependencies and priority
5. Flag capacity risks

## Output Format

### Sprint Goal
One-sentence summary of what this sprint achieves.

### Tasks
| # | Task | Size | Depends On | Priority |
|---|------|------|-----------|----------|

### Risks
What could derail this sprint?

### Definition of Done
What must be true for the sprint to be considered complete?
