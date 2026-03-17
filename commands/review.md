---
name: review
description: 4-round code review — spec alignment, functional, quality, compliance
argument-hint: "[file, directory, or git ref to review]"
user-invocable: true
context: fork
model: opus
---

# Review: $ARGUMENTS

You are the team lead coordinating a 4-round review.

## Target

Accepted targets:
- File or directory path
- Git ref (`HEAD`, branch name, commit SHA)
- Git range (`main..HEAD`, `HEAD~3..HEAD`)
- If none specified, review uncommitted changes via `git diff`

## Team

Spawn all reviewers as a team:

```
TeamCreate("review-team")
```

### Teammates
- **spec-reviewer** (reviewer-code): Spec alignment — verifies implementation against initiative specs
- **func-reviewer** (reviewer-code): Functional — correctness, edge cases, best practices
- **quality-reviewer** (reviewer-code): Quality — code patterns, performance, security
- **arch-reviewer** (reviewer-architecture): Compliance — architecture fit, scalability, accessibility, i18n

**If an agent doesn't exist:** Handle that round directly using the same approach.

## Round 1: Spec Alignment

**Spawn: spec-reviewer** → Check if the implementation matches the initiative specs.

1. Identify the initiative by looking at the files being reviewed — match them to an initiative folder under `initiatives/`
2. Read all specs in the initiative folder (`product/prd.md`, `engineering/plan.md`)
3. Verify:
   - All PRD requirements and acceptance criteria are implemented
   - Architecture matches the plan (components, data flow, state management)
   - Design spec is followed (layout, interactions, responsive behavior)
4. Flag: missing features, deviations from spec, unspecified behavior that should be documented

If no matching initiative or specs are found, skip this round and note it in the report.

## Round 2: Functional

**Spawn: func-reviewer** → Does it work? Edge cases handled? Include Round 1 context.

## Round 3: Quality

**Spawn: quality-reviewer** → Code patterns, readability, maintainability, performance, security — include Round 1-2 context.

## Round 4: Compliance

**Spawn: arch-reviewer** → Architecture fit, project patterns, accessibility, i18n — include Round 1-3 context.

## Final Report

**You (lead):** Compile all findings:

- Spec coverage (% of requirements met, gaps) — omit if Round 1 was skipped
- Summary (total issues by severity)
- Critical issues (with file:line and fixes)
- Major issues (with file:line and fixes)
- Minor issues
- Overall assessment (merge readiness)

Send `shutdown_request` to all teammates, wait for confirmations, call `TeamDelete`.

Present to user.
