---
name: feature
description: Full product workflow — understand, research, build, and review a feature
argument-hint: "[feature description]"
user-invocable: true
context: fork
model: opus
---

# Feature: $ARGUMENTS

You are Claude Code coordinating a 4-stage workflow.

## How to Spawn Agents

**Subagents (sequential phases):** Use the Task tool to spawn agents by name for
research and review work where peer communication is not needed.

**Teammates (parallel build phase):** Use TeamCreate to create a team, then spawn
engineering agents as teammates with the `team_name` parameter. Teammates communicate
directly via SendMessage and coordinate through a shared task list.

Pass context between stages:
- Feature name and description
- Initiative folder path
- Relevant outputs from previous stages

**If an agent doesn't exist:** Handle that task directly using the same approach.

---

## Stage 1: Understand (Subagents)

**You (Claude Code):**
1. Ask the user: What problem? Who is the user? What does success look like? In/out of scope?
2. Wait for answers
3. Create folder: `initiatives/{feature-name}-{date}/`

**Spawn: product-lead** → Write `initiative.md` with user's answers

**Gate:** Present to user. "Approve to proceed to Research?"

---

## Stage 2: Research (Subagents)

**Spawn: researcher** → Research the feature, write to `research/`

**You (Claude Code):** Present findings. Ask about scope changes.

**Spawn: product-lead** → Update `initiative.md` with research summary

**Gate:** "Approve to proceed to Build?"

---

## Stage 3: Build (Team Phase)

### 3a. Spec

**Spawn: product-lead** (subagent) → Create `spec.md` with user stories and technical approach

**Gate:** Present spec. "Approve to start building?"

### 3b. Create Team

**You (Claude Code):** Analyze spec, determine which domains are needed.

```
TeamCreate("feature-{feature-slug}")
```

Use kebab-case for the slug derived from the feature name (e.g., "feature-user-profile").
Before creating a team, verify no existing team is active. If one exists, prompt the
user to confirm teardown before proceeding.

### 3c. Create Tasks

Use TaskCreate for each work unit derived from the spec. Set dependencies so work
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

### 3d. Spawn Teammates

Spawn only the agents needed as teammates. Each teammate receives:
- The feature description, spec.md content, and initiative context
- Their assigned tasks from the decomposition
- Instructions to check TaskList and coordinate via SendMessage

```
Task({
  team_name: "feature-{feature-slug}",
  name: "eng-frontend",
  subagent_type: "general-purpose",
  prompt: "{feature context + spec + assigned tasks + team instructions}"
})
```

Run all teammate spawns in parallel. Include `run_in_background: true`.

### 3e. Monitor

- Check TaskList periodically to track progress
- Resolve blockers — if a teammate is stuck, send them a message or reassign work
- When teammates send messages about interface changes or questions, relay relevant
  context to affected teammates if needed

### 3f. Teardown

When all tasks are completed:
1. Send `shutdown_request` to each teammate
2. Wait for shutdown confirmations
3. Call `TeamDelete` to clean up

### 3g. Integrate

**You (Claude Code):**
- Verify integration points work together
- Run tests
- If issues found, spawn appropriate agent (as subagent) to fix
- If integration requires coordinated multi-domain fixes, re-run the Build phase

---

## Stage 4: Review (Subagents)

Run sequentially — each round informs the next:

1. **Spawn: reviewer-code** → Round 1: Functional (meets requirements?)
2. **Spawn: reviewer-code** → Round 2: Quality (code quality, security, performance) — include Round 1 context
3. **Spawn: reviewer-architecture** → Round 3: Compliance (architecture, a11y, i18n) — include Round 1-2 context

**You (Claude Code):** Compile all findings into `review-report.md`, present to user.

---

## Deliverables

`initiatives/{feature-name}-{date}/`:
- `initiative.md`
- `research/`
- `spec.md`
- `review-report.md`
- Working implementation
