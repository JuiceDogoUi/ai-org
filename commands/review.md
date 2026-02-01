---
name: review
description: 3-round review — functional, quality, compliance
argument-hint: "[file, directory, or git ref to review]"
context: fork
agent: orchestrator
---

Review the following with a 3-round process: $ARGUMENTS

If no target specified, review uncommitted changes via `git diff`.

Skip any agent that is not available in the project.

## Round 1 — Functional

- **eng-testing**: Run tests, verify all pass
- **reviewer-code**: Verify code correctness and that changes work as intended

## Round 2 — Quality

- **reviewer-code**: Full code review (style, patterns, bugs, security)
- **eng-performance** (if available): Performance review
- **reviewer-architecture** (if available): Architecture and component design review

## Round 3 — Compliance

- **compliance** (if available): GDPR and WCAG compliance check
- **reviewer-content** (if available): SEO and schema review
- **positioning** (if available): Verify alignment with product positioning and guidelines

## Output Format

Organize feedback by severity:

### Critical (must fix before merge)
Issues that will cause bugs, security vulnerabilities, or data loss.

### Warning (should fix)
Issues that may cause problems or degrade quality over time.

### Suggestion (consider improving)
Improvements to readability, performance, or maintainability.

For each finding include:
- **File:line** — exact location
- **Issue** — what the problem is
- **Why** — why it matters
- **Fix** — specific recommended change

### Summary

Consolidated summary across all three rounds with overall assessment.
