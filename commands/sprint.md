---
name: sprint
description: Plan and organize a sprint
argument-hint: "[sprint goal or scope]"
context: fork
agent: project-manager
---

Plan and organize a sprint. Sprint goal or scope (if provided): $ARGUMENTS

You MUST follow this workflow exactly.

## Step 1: Assess Current State

- Read open issues/tasks — check `.claude/plans/`, any existing backlog files, and recent plan documents
- Check recent commits (`git log --oneline -20`) to understand what was recently completed
- Review any existing sprint plans in `.claude/plans/sprint-*.md`
- Read `CLAUDE.md` for project context, conventions, and current priorities

## Step 2: Define Sprint Scope

Based on the sprint goal argument (if provided) or the current project state:

1. Identify candidate work items — features, bugs, improvements, tech debt
2. For each candidate, note:
   - Source (issue, plan doc, backlog, or inferred from code)
   - Brief description
   - Why now (urgency, dependency, user impact)
3. Present the candidate list to the user and ask them to confirm which items to include in the sprint

## Step 3: Break Down Work

For each confirmed sprint item, decompose into concrete tasks:

- **Description**: What needs to be done (specific and actionable)
- **Complexity**: S (< half day), M (half day to 2 days), L (2+ days)
- **Dependencies**: Which other tasks must complete first
- **Agent**: Which ai-org agent is best suited (e.g., eng-frontend, eng-api, writer-content)
- **Acceptance criteria**: How to verify the task is done

## Step 4: Organize Sprint

Create a sprint plan document at `.claude/plans/sprint-{YYYY-MM-DD}.md` containing:

```markdown
# Sprint: {sprint goal}
**Created**: {date}
**Duration**: {suggested duration based on scope}

## Goal
{One-sentence sprint goal}

## Tasks

| # | Task | Complexity | Agent | Dependencies | Status |
|---|------|-----------|-------|-------------|--------|
| 1 | ... | S/M/L | ... | — | pending |
| 2 | ... | S/M/L | ... | 1 | pending |

## Dependency Graph
{Show which tasks block which, in text or ASCII format}

## Risks
- {Identify blockers, unknowns, or items that could delay the sprint}
```

## Step 5: Output

Present the sprint plan with:
- Total task count and breakdown by complexity (S/M/L)
- Critical path (longest chain of dependent tasks)
- Suggested execution order
- Any risks or open questions

Related commands: `/estimate` for individual task estimation, `/plan` for detailed implementation planning, `/status` for project status.
