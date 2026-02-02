# 3-Round Review Process

This is the canonical review framework used by `/review`, `/build` (auto-review), and `/feature` (Stage 4).

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

## Output

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
