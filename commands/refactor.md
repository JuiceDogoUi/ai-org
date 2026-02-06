---
name: refactor
description: Refactor code with pre and post review
argument-hint: "[target and refactoring goal]"
user-invocable: true
context: fork
model: sonnet
---

# Refactor: $ARGUMENTS

You are Claude Code coordinating a refactoring workflow.

## How to Spawn Agents

Use the Task tool. Spawn each agent by name (e.g., `reviewer-code`, `eng-frontend`).

**If an agent doesn't exist:** Handle that task directly using the same approach.

---

## Step 1: Pre-Review

**Spawn: reviewer-code** → Analyze current state, identify code smells, maintainability issues

**Gate:** Present pre-review findings to user. "Approve to proceed with refactoring?"

---

## Step 2: Refactor

**You (Claude Code):** Determine code type, spawn appropriate agent:

- Frontend code → **Spawn: eng-frontend**
- Backend code → **Spawn: eng-backend**
- Styles → **Spawn: eng-styles**

Pass: target, goal, "preserve existing behavior, no new features"

---

## Step 3: Post-Review

**Spawn: reviewer-code** → Verify goal achieved, behavior preserved, no new issues — include pre-review context

---

## Step 4: Verify

**Spawn: eng-testing** → Run existing tests, confirm no regressions

---

## Standards

- Preserve existing behavior
- Stay focused on stated goal
- No feature additions

---

## Deliverables

- Refactored code
- Pre-review findings
- Post-review confirmation
- Test results (no regressions)
