---
name: estimate
description: Estimate effort for a task or feature
argument-hint: "[task description]"
context: fork
agent: project-manager
---

Estimate the effort for: $ARGUMENTS

## Process

1. Analyze the codebase to understand scope and complexity
2. Break down into subtasks
3. Assess complexity factors for each subtask
4. Identify risk factors that could increase scope

## Output Format

### Overall Estimate
T-shirt size (S/M/L/XL) with rationale.

### Breakdown
| Subtask | Complexity | Notes |
|---------|-----------|-------|

### Risk Factors
What could make this larger than estimated?

### Dependencies
What must be in place before this can start?
