---
name: status
description: Generate project status report
argument-hint: "[optional: focus area]"
model: haiku
allowed-tools: Bash(git *), Read, Grep, Glob
---

Generate a project status report.

## Context

!`git log --oneline -20`
!`git diff --stat`
!`git branch -a`

## Instructions

Summarize:
- **Recent activity**: What was done in the last 20 commits
- **Current state**: What branch we're on, uncommitted changes
- **Active branches**: What's in progress across branches
- **Next steps**: What appears to be in progress or needs attention
