---
name: review
description: 3-round review — functional, quality, compliance
argument-hint: "[file, directory, or git ref to review]"
context: fork
agent: orchestrator
---

Review the following with a 3-round process: $ARGUMENTS

Accepted targets:
- A file or directory path
- A git ref (`HEAD`, branch name, commit SHA)
- A git range (`main..HEAD`, `HEAD~3..HEAD`)
- If no target specified, review uncommitted changes via `git diff`

Follow the 3-round review process defined in `skills/review-process/SKILL.md`.

## Output

Consolidated findings from all three rounds, organized by severity (critical, warning, suggestion) with file:line references and specific fixes. End with an overall assessment and merge readiness verdict.

> Related: `/build` runs this automatically after building, `/refactor` includes pre and post review.
