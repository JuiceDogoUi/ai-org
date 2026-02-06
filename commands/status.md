---
name: status
description: Generate project status report
argument-hint: "[optional: focus area]"
user-invocable: true
context: fork
model: haiku
allowed-tools: Bash(git *), Read, Grep, Glob
---

# Status: $ARGUMENTS

You are Claude Code. Generate a project status report directly — this is a simple analysis task.

## Context

!`git log --oneline -20`
!`git diff --stat`
!`git branch -a`

## Process

Summarize:
- **Recent activity**: What was done in the last 20 commits
- **Current state**: What branch we're on, uncommitted changes
- **Active branches**: What's in progress across branches
- **Next steps**: What appears to be in progress or needs attention

## Output

```
## Project Status

### Recent Activity
- {summary of recent commits grouped by theme}

### Current State
- Branch: {current branch}
- Uncommitted changes: {summary or "none"}

### Active Branches
| Branch | Last Activity | Status |
|--------|--------------|--------|

### Next Steps
- {what needs attention}
```

> Related: `/changelog` for a release-oriented changelog.
