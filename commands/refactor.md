---
name: refactor
description: Refactor code with pre and post review
argument-hint: "[target and refactoring goal]"
context: fork
model: sonnet
---

# Refactor: $ARGUMENTS

You are Claude Code coordinating a refactoring with pre/post review. You spawn agents at each stage.

---

## Step 1: Pre-Review

Spawn reviewer to analyze current state:

```
Task(
  subagent_type="general-purpose",
  prompt="You are the reviewer-code agent. Read .claude/agents/reviewer-code.md. Analyze the current state of: {target}. Identify code smells, maintainability issues, and what should be improved. This is a pre-refactor review."
)
```

## Step 2: Refactor

Based on the code being refactored, spawn the appropriate agent:

**Frontend code:**
```
Task(
  subagent_type="general-purpose",
  prompt="You are the eng-frontend agent. Read .claude/agents/eng-frontend.md. Refactor: {target} to achieve: {goal}. Preserve existing behavior. Do not add features."
)
```

**Backend code:**
```
Task(
  subagent_type="general-purpose",
  prompt="You are the eng-backend agent. Read .claude/agents/eng-backend.md. Refactor: {target} to achieve: {goal}. Preserve existing behavior. Do not add features."
)
```

**Styles:**
```
Task(
  subagent_type="general-purpose",
  prompt="You are the eng-styles agent. Read .claude/agents/eng-styles.md. Refactor: {target} to achieve: {goal}. Preserve existing behavior."
)
```

## Step 3: Post-Review

Spawn reviewer to validate the refactoring:

```
Task(
  subagent_type="general-purpose",
  prompt="You are the reviewer-code agent. Read .claude/agents/reviewer-code.md. Review the refactoring changes. Confirm the goal was achieved, behavior was preserved, and no new issues were introduced."
)
```

## Step 4: Verify

Spawn testing to confirm no regressions:

```
Task(
  subagent_type="general-purpose",
  prompt="You are the eng-testing agent. Read .claude/agents/eng-testing.md. Run existing tests to confirm the refactoring caused no regressions. Report results."
)
```

---

## Standards

- Preserve all existing behavior unless explicitly told otherwise
- Keep the refactoring focused on the stated goal
- Do not add features or change behavior during refactoring

## Output

- Refactored code with all tests passing
- Pre-review findings (what was wrong before)
- Post-review confirmation (what improved)
- Test results confirming no regressions
