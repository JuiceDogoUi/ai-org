---
name: estimate
description: Estimate effort for a task or feature
argument-hint: "[task description]"
context: fork
agent: project-manager
---

Estimate the effort for: $ARGUMENTS

## Process

1. **Scope**: Read the codebase to understand what exists and what needs to change
2. **Decompose**: Break into subtasks — each subtask should be a single deliverable unit
3. **Assess each subtask**:
   - How many files touched?
   - New code vs. modifying existing code?
   - Are there unknowns (new library, unfamiliar pattern)?
   - Does it require coordination across domains (frontend + backend)?
4. **Size**: Assign T-shirt size per subtask:
   - **S**: ≤3 files, clear approach, no unknowns
   - **M**: 4-10 files, some complexity, minor unknowns
   - **L**: 10+ files, cross-domain, significant unknowns
   - **XL**: Architectural change, many unknowns, high risk
5. **Risk-adjust**: Identify factors that could inflate scope

## Output

### Overall Estimate
T-shirt size (S/M/L/XL) with rationale.

### Breakdown
| Subtask | Size | Files | Notes |
|---------|------|-------|-------|

### Risk Factors
What could make this larger than estimated?

### Dependencies
What must be in place before this can start?

> Related: `/plan` to create the implementation plan for the estimated work, `/feature` for the full product workflow.
