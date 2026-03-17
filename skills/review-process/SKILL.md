---
name: review-process
description: 4-round review methodology — spec alignment, functional, quality, and compliance review
user-invocable: false
---

# 4-Round Review Methodology

> **Documentation Freshness**: Review practices evolve with tooling — automated
> code analysis, AI-assisted review, and CI integration change how reviews are
> conducted. Adapt the methodology to your team's tools and workflow.

## File Guide
- **review-output-format.md** — Severity classification rules, finding format, summary template
- **round-details.md** — Expanded guidance for each review round with role-specific checks

A structured approach to code and content review covering four dimensions: spec alignment, functional correctness, quality standards, and compliance requirements.

## Round 0 — Spec Alignment

Verify the implementation matches the initiative specs.

- **PRD requirements met** — All acceptance criteria from `product/prd.md` are implemented
- **Architecture matches plan** — Components, data flow, and state management follow `engineering/plan.md`
- **Design spec followed** — Layout, interactions, and responsive behavior match design documents
- **No unspecified behavior** — Flag behavior that exists in code but not in any spec
- **Skip if no specs** — If no matching initiative or specs folder exists, skip this round and note it

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

## Severity Levels & Finding Format

See **review-output-format.md** for severity classification rules (Critical / Warning / Suggestion), finding format template, and summary format.

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
