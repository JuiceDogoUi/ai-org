---
name: build
description: Build a feature end-to-end with coordinated agents
argument-hint: "[feature description]"
context: fork
model: opus
---

# Build: $ARGUMENTS

You are Claude Code acting as the build coordinator. You do NOT implement code yourself — you spawn specialist agents via the Task tool.

**Your role:** Analyze what needs to be built, decompose into tasks, spawn the right agents, and coordinate results.

---

## Step 1: Analyze

Read the codebase to understand:
- What needs to be built
- Which domains are involved (frontend, backend, API, styles, etc.)
- What files will be affected

## Step 2: Decompose

Break down the work into agent-appropriate tasks:
- Frontend components/screens → eng-frontend
- Backend services/handlers → eng-backend
- API contracts → eng-api
- Styling/CSS → eng-styles
- Database migrations → eng-backend

## Step 3: Execute

Spawn agents for each task. **Run independent tasks in parallel.**

**Frontend:**
```
Task(
  subagent_type="general-purpose",
  prompt="You are the eng-frontend agent. Read .claude/agents/eng-frontend.md for your full instructions, then read relevant .claude/skills/. Implement: {specific frontend task}"
)
```

**Backend:**
```
Task(
  subagent_type="general-purpose",
  prompt="You are the eng-backend agent. Read .claude/agents/eng-backend.md for your full instructions, then read relevant .claude/skills/. Implement: {specific backend task}"
)
```

**Styles:**
```
Task(
  subagent_type="general-purpose",
  prompt="You are the eng-styles agent. Read .claude/agents/eng-styles.md for your full instructions, then read relevant .claude/skills/. Implement: {specific styling task}"
)
```

**API:**
```
Task(
  subagent_type="general-purpose",
  prompt="You are the eng-api agent. Read .claude/agents/eng-api.md for your full instructions. Define: {API contracts}"
)
```

**Testing:**
```
Task(
  subagent_type="general-purpose",
  prompt="You are the eng-testing agent. Read .claude/agents/eng-testing.md for your full instructions. Write tests for: {what was built}"
)
```

## Step 4: Integrate

After agents complete:
- Verify integration points work together
- Run the tests
- Fix any integration issues by spawning the appropriate agent

## Step 5: Auto-Review

Spawn the review workflow:

```
Task(
  subagent_type="general-purpose",
  prompt="You are the reviewer-code agent. Read .claude/agents/reviewer-code.md and .claude/skills/review-process/SKILL.md. Perform a 3-round review of the changes: Round 1 (Functional), Round 2 (Quality), Round 3 (Compliance)."
)
```

---

## Output

- Working implementation across affected files
- Tests passing
- Review report with findings by severity
- Summary of what was built and by which agents
