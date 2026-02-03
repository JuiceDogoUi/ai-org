---
name: build
description: Build a feature end-to-end with coordinated agents
argument-hint: "[feature description]"
context: fork
model: opus
---

# Build: $ARGUMENTS

You are Claude Code coordinating a build workflow.

## How to Spawn Agents

Use the Task tool. Each agent reads its instructions from `.claude/agents/{agent-name}.md` and skills.

**If an agent doesn't exist:** Handle that task directly using the same approach.

---

## Step 1: Analyze

**You (Claude Code):** Read the codebase to understand:
- What needs to be built
- Which domains are involved (frontend, backend, API, styles)
- What files will be affected

---

## Step 2: Decompose

Break down work by domain:
- UI components/screens → **eng-frontend**
- Backend services/handlers → **eng-backend**
- API contracts → **eng-api**
- Styling/CSS → **eng-styles**
- Database changes → **eng-backend**

---

## Step 3: Execute

Spawn only the agents needed (if they exist). Run independent tasks in parallel.

- **Spawn: eng-frontend** → frontend implementation
- **Spawn: eng-backend** → backend implementation
- **Spawn: eng-api** → API contracts
- **Spawn: eng-styles** → styling work

---

## Step 4: Test

**Spawn: eng-testing** → Write tests, verify implementation

---

## Step 5: Integrate

**You (Claude Code):**
- Verify integration points work together
- Run tests
- If issues found, spawn appropriate agent to fix

---

## Step 6: Review

Run sequentially — each round informs the next:

1. **Spawn: reviewer-code** → Round 1: Functional
2. **Spawn: reviewer-code** → Round 2: Quality — include Round 1 context
3. **Spawn: reviewer-architecture** → Round 3: Compliance — include Round 1-2 context

**You (Claude Code):** Compile findings, present to user.

---

## Deliverables

- Working implementation
- Tests passing
- Review report with findings by severity
