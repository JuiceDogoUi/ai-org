---
name: review
description: 3-round code review — functional, quality, compliance
argument-hint: "[file, directory, or git ref to review]"
user-invocable: true
context: fork
model: sonnet
---

# Review: $ARGUMENTS

You are Claude Code coordinating a 3-round review.

## How to Spawn Agents

Use the Task tool. Spawn each agent by name (e.g., `reviewer-code`, `reviewer-architecture`).

**If an agent doesn't exist:** Handle that task directly using the same approach.

---

## Target

Accepted targets:
- File or directory path
- Git ref (`HEAD`, branch name, commit SHA)
- Git range (`main..HEAD`, `HEAD~3..HEAD`)
- If none specified, review uncommitted changes via `git diff`

---

## Round 1: Functional

**Spawn: reviewer-code** → Does it work? Does it meet requirements? Edge cases handled?

---

## Round 2: Quality

**Spawn: reviewer-code** → Code patterns, readability, maintainability, performance, security — include Round 1 context

---

## Round 3: Compliance

**Spawn: reviewer-architecture** → Architecture fit, project patterns, accessibility, i18n — include Round 1-2 context

---

## Final Report

**You (Claude Code):** Compile all findings into a report:

- Summary (total issues by severity)
- Critical issues (with file:line and fixes)
- Major issues (with file:line and fixes)
- Minor issues
- Overall assessment (merge readiness)

Present to user.
