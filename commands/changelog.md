---
name: changelog
description: Generate a changelog from recent commits
argument-hint: "[version or date range]"
model: haiku
allowed-tools: Bash(git *), Read
---

Generate a changelog for: $ARGUMENTS

## Context

!`git log --oneline --no-merges -50`

## Instructions

Categorize the commits above into:
- **Added**: New features
- **Changed**: Changes to existing functionality
- **Fixed**: Bug fixes
- **Removed**: Removed features or deprecated items

Write user-facing descriptions, not raw commit messages.
Keep entries concise -- one line per change.
