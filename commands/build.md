---
name: build
description: Build a feature end-to-end with coordinated agents
argument-hint: "[feature description]"
user-invocable: true
context: fork
model: opus
---

# Build: $ARGUMENTS

You are Claude Code coordinating a build workflow.

## How to Spawn Agents

**Subagents (sequential phases):** Use the Task tool to spawn agents by name for
research and review work where peer communication is not needed.

**Teammates (parallel build phase):** Use TeamCreate to create a team, then spawn
engineering agents as teammates with the `team_name` parameter. Teammates communicate
directly via SendMessage and coordinate through a shared task list.

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

**Gate:** Present the decomposition to user. "Approve to start building?"

---

## Step 3: Build (Team Phase)

Create a team for the parallel build phase. Engineering agents work as teammates
with direct peer communication and a shared task list.

### 3a. Create Team

```
TeamCreate("build-{feature-slug}")
```

Use kebab-case for the slug derived from the feature name (e.g., "build-user-profile").
Before creating a team, verify no existing team is active. If one exists, prompt the
user to confirm teardown before proceeding.

### 3b. Create Tasks

Use TaskCreate for each work unit from the decomposition. Set dependencies so work
flows naturally (API contracts unblock frontend and backend, components unblock styles).

Create tasks first with TaskCreate, then use TaskUpdate to set `owner` and `addBlockedBy`
for each task. TaskCreate only accepts subject, description, and activeForm.

Example task structure:
- Task: "Define API contracts" → assign to eng-api
- Task: "Implement service layer" → assign to eng-backend, blocked by API task
- Task: "Build UI components" → assign to eng-frontend, blocked by API task
- Task: "Style components" → assign to eng-styles, blocked by UI task
- Task: "Write tests" → assign to eng-testing, blocked by service + UI tasks

For a backend-only feature, you might only need eng-api, eng-backend, and eng-testing.
Only create tasks for domains that are actually needed.

### 3c. Spawn Teammates

Spawn only the agents needed as teammates. Each teammate receives:
- The feature description and context
- Their assigned tasks from the decomposition
- Instructions to check TaskList and coordinate via SendMessage

```
Task({
  team_name: "build-{feature-slug}",
  name: "eng-frontend",
  subagent_type: "general-purpose",
  prompt: "{feature context + assigned tasks + team instructions}"
})
```

Run all teammate spawns in parallel. Include `run_in_background: true`.

### 3d. Monitor

- Check TaskList periodically to track progress
- Resolve blockers — if a teammate is stuck, send them a message or reassign work
- When teammates send messages about interface changes or questions, relay relevant
  context to affected teammates if needed

### 3e. Teardown

When all tasks are completed:
1. Send `shutdown_request` to each teammate
2. Wait for shutdown confirmations
3. Call `TeamDelete` to clean up

### 3f. Integrate

**You (Claude Code):**
- Verify integration points work together
- Run tests
- If issues found, spawn appropriate agent (as subagent) to fix
- If integration requires coordinated multi-domain fixes, re-run the Build phase

---

## Step 4: Review (Subagents)

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
