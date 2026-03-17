---
name: build
description: Build a feature end-to-end with coordinated agents
argument-hint: "[feature description]"
user-invocable: true
context: fork
model: opus
---

# Build: $ARGUMENTS

You are the team lead coordinating a build workflow. Create an agent team.

## Team

Always spawn:
- **architect** (eng-architect): Architecture, file structure, data model
- **challenger** (challenger): Devil's advocate — challenges architecture and implementation decisions
- **tester** (eng-testing): Writes tests before and validates after build

Spawn based on domains involved:
- **frontend** (eng-frontend): UI work
- **backend** (eng-backend): API/DB work
- **api** (eng-api): API contracts
- **styles** (eng-styles): Styling
- **reviewer** (reviewer-code): Always — at end
- **arch-reviewer** (reviewer-architecture): Always — at end

**If an agent doesn't exist:** Handle that task directly using the same approach.

## Existing Work

Check if an initiative folder or spec exists for this feature in `initiatives/`. If found, read existing artifacts (`engineering/plan.md`, `product/prd.md`, `research/`) and use them as the foundation — skip or accelerate the Architecture step.

## Step 1: Analyze

You (lead) read the codebase to understand:
- What needs to be built
- Which domains are involved (frontend, backend, API, styles)
- What files will be affected

## Step 2: Architecture

Architect defines the plan (or refines the existing plan from a prior run). After architect finishes, challenger reviews it — challenges assumptions, finds risks, proposes simpler alternatives.

**If challenger verdict is BLOCKED:** Present critical issues to user. User decides: re-plan, override, or abandon.
**If PASS WITH CONDITIONS:** Architect addresses major issues before proceeding.

**Gate:** Present plan to user with challenger's concerns addressed. "Approve to start?"

## Step 3: Test (spec-based, BEFORE build)

**Spawn: eng-testing** → Write tests based on:
- Specs from `product/prd.md` (if initiative exists)
- Architecture plan from `engineering/plan.md`
- The decomposition from Step 2

If no specs exist (ad-hoc build without prior `/feature` or `/explore`), tester writes tests based on the architecture plan and the lead's analysis from Step 1.

Tests define expected behavior BEFORE code exists. **They will fail initially — that's expected.**

**Gate:** Tests written. "Approve to build?"

## Step 4: Build (Team Phase)

### 4a. Create Team
```
TeamCreate("build-{feature-slug}")
```

### 4b. Create Tasks
Use TaskCreate for each work unit from the plan. Set dependencies so work flows naturally (API contracts unblock frontend and backend, components unblock styles).

Create tasks first with TaskCreate, then use TaskUpdate to set `owner` and `addBlockedBy`. Teammates can also self-claim unassigned, unblocked tasks.

**Include the pre-written tests in each task description** — engineers know what their code must pass.

### 4c. Spawn Teammates
Spawn only the agents needed as teammates. Run in parallel with `run_in_background: true`.

### 4d. Monitor
Check TaskList periodically. Resolve blockers — if a teammate is stuck, send them a message or reassign work. Teammates coordinate directly via SendMessage for interface changes.

### 4e. Teardown
When all tasks complete, send `shutdown_request` to each teammate, wait for confirmations, call `TeamDelete`.

### 4f. Integrate
Verify integration points work together. If issues found, spawn agent to fix.

## Step 5: Validate

Run in parallel:
- **Run pre-written tests** against the built code
- **Challenger** reviews implementation — missed edge cases, unnecessary complexity, integration risks

**If tests fail:** Spawn appropriate engineering agent(s) to fix. Re-run until passing.

**If challenger verdict is BLOCKED:** Present critical issues to user. User decides: fix, override, or proceed to review.
**If PASS WITH CONDITIONS:** Spawn appropriate agent(s) to address major issues.

**Gate:** All tests passing.

## Step 6: Review

```
TeamCreate("review-{feature-slug}")
```

Spawn reviewers as a team:

1. **func-reviewer** (reviewer-code): Functional — correctness, edge cases
2. **quality-reviewer** (reviewer-code): Quality — code patterns, performance, security
3. **arch-reviewer** (reviewer-architecture): Compliance — architecture fit, scalability, accessibility

**You (lead):** Compile findings, present to user. Clean up the team.

## Deliverables

- Working implementation with passing tests
- `review-report.md` with findings by severity (if initiative folder exists)
