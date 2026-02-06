---
name: changelog
description: Generate a changelog from recent commits
argument-hint: "[version or date range]"
user-invocable: true
context: fork
model: haiku
allowed-tools: Bash(git *), Read
---

# Changelog: $ARGUMENTS

You are Claude Code. Generate a changelog directly — this is a simple formatting task.

## Context

!`git log --oneline --no-merges -50`

## Process

Categorize the commits above into:
- **Added**: New features
- **Changed**: Changes to existing functionality
- **Fixed**: Bug fixes
- **Removed**: Removed features or deprecated items

Write user-facing descriptions, not raw commit messages.
Keep entries concise -- one line per change.
Omit empty categories.

## Output

Changelog in [Keep a Changelog](https://keepachangelog.com/) format:

```
## [{version or date}]

### Added
- {description}

### Changed
- {description}

### Fixed
- {description}
```

> Related: `/status` for a broader project status report.
