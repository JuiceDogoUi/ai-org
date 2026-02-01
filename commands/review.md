---
name: review
description: Review code changes for quality, security, and best practices
argument-hint: "[file, directory, or git ref to review]"
context: fork
agent: reviewer-code
---

Review the following for code quality: $ARGUMENTS

If no target specified, review uncommitted changes via `git diff`.

## Output Format

Organize feedback by severity:

### Critical (must fix before merge)
Issues that will cause bugs, security vulnerabilities, or data loss.

### Warning (should fix)
Issues that may cause problems or degrade quality over time.

### Suggestion (consider improving)
Improvements to readability, performance, or maintainability.

For each finding include:
- **File:line** -- exact location
- **Issue** -- what the problem is
- **Why** -- why it matters
- **Fix** -- specific recommended change
