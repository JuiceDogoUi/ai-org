---
name: review-process
description: 3-round review methodology for functional, quality, and compliance review
user-invocable: false
---

# 3-Round Review Methodology

A structured approach to code and content review covering three dimensions: functional correctness, quality standards, and compliance requirements.

## Round 1 — Functional Review

Verify the work does what it's supposed to do.

- **Tests pass** — All automated tests run successfully
- **Acceptance criteria met** — Changes satisfy the stated requirements
- **No regressions** — Existing functionality remains intact
- **Edge cases handled** — Error states, empty states, boundary conditions

## Round 2 — Quality Review

Assess code/content quality and maintainability.

- **Readability** — Clear naming, appropriate comments, logical structure
- **Patterns** — Follows established project conventions
- **Performance** — No obvious inefficiencies, appropriate data structures
- **Security** — No vulnerabilities introduced (input validation, auth, data exposure)
- **Testability** — Code is structured for testing, adequate test coverage

## Round 3 — Compliance Review

Check regulatory and organizational requirements.

- **Accessibility** — WCAG compliance, keyboard navigation, screen reader support
- **Privacy** — Data handling, consent, PII protection, GDPR/CCPA compliance
- **Licensing** — Dependencies are properly licensed
- **Branding** — Follows brand guidelines and voice (for content)
- **SEO** — Metadata, structure, schema markup (for public content)

## Severity Levels

Organize findings by severity to prioritize fixes:

### Critical (must fix before merge)
Issues that will cause bugs, security vulnerabilities, data loss, or legal exposure.

### Warning (should fix)
Issues that may cause problems or degrade quality over time.

### Suggestion (consider improving)
Improvements to readability, performance, or maintainability that aren't blocking.

## Finding Format

For each finding include:

- **File:line** — Exact location
- **Issue** — What the problem is
- **Why** — Why it matters
- **Fix** — Specific recommended change

## Review Checklist

### Code Review
- [ ] Logic is correct and handles edge cases
- [ ] No security vulnerabilities (injection, XSS, auth bypass)
- [ ] Error handling is appropriate
- [ ] Performance is acceptable
- [ ] Tests cover the changes
- [ ] Documentation updated if needed

### Content Review
- [ ] Accurate and complete information
- [ ] Clear and scannable structure
- [ ] Consistent voice and tone
- [ ] Accessible language
- [ ] SEO requirements met (if applicable)
- [ ] Links and references validated

## Avoid

- **Skipping functional review** — Never review quality before confirming the work actually works
- **Blocking on suggestions** — Only critical issues should block merge; suggestions are optional
- **Reviewing without context** — Understand the requirements and constraints before reviewing
- **Nitpicking style** — Focus on bugs, security, and maintainability; style is for linters
- **Rubber-stamping** — Every review should provide value; if you can't review properly, say so
- **Late compliance review** — Surface legal and accessibility issues early, not at the end
- **Personal preferences as requirements** — Distinguish objective issues from subjective preferences
- **Missing reproduction steps** — Every bug report needs steps to reproduce
- **Vague feedback** — "This needs work" isn't actionable; specify what and why
- **Review ping-pong** — Consolidate feedback in one pass; don't drip-feed issues
