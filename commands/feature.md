---
name: feature
description: Full product workflow — discover, spec, test, build, validate, and review a feature
argument-hint: "[feature description]"
user-invocable: true
context: fork
model: opus
---

# Feature: $ARGUMENTS

You are the team lead coordinating a full feature workflow. Create an agent team.

## Team

Spawn in Stage 1 (parallel research):
- **product** (product-lead): Lightweight initiative framing — problem, scope, success criteria only
- **researcher** (researcher): Market research — competitors, best practices, trends, user sentiment, technology capabilities
- **challenger** (challenger): Devil's advocate — challenges decisions at key inflection points

Spawn in Stage 2 (parallel, AFTER research completes):
- **product** continues: Detailed PRD informed by research findings
- **designer** (design-lead): User flows, component specs, interaction patterns — collaborates with product
- **architect** (eng-architect): Architecture, file structure, data model
- **api** (eng-api): API contracts, endpoints, request/response schemas

Spawn in Stage 3:
- **tester** (eng-testing): Writes tests from specs BEFORE code exists

Spawn in Stage 4 based on domains:
- **frontend** (eng-frontend): UI work
- **backend** (eng-backend): API/DB work
- **styles** (eng-styles): Styling

Stage 5 (Validate) reuses **tester** and **challenger** from earlier stages.

Spawn in Stage 6:
- **reviewer** (reviewer-code): Always
- **arch-reviewer** (reviewer-architecture): Always

**If an agent doesn't exist:** Handle that task directly using the same approach.

## Folder Structure

Use ISO date format: `initiatives/{feature-name}-YYYY-MM-DD/`

Check if an initiative folder already exists for this feature (e.g., from a prior `/explore` or `/plan` run). If it does, read existing artifacts — skip or accelerate stages where work is already done. Product enriches existing docs instead of rewriting. Researcher skips files that already exist unless the scope has changed.

Create folder structure (if it doesn't exist):
```
initiatives/{feature-name}-YYYY-MM-DD/
├── product/
├── engineering/
├── research/
└── tests/
```

## Stage 1: Discover

You (lead) ask the user: What problem? Who is the user? What does success look like? In/out of scope?

Wait for answers. Then spawn product and researchers in parallel:

**Product** writes `product/{feature-name}.md` — lightweight initiative framing ONLY:
- Problem statement and context
- Target users and personas affected
- Success criteria and metrics
- Scope boundaries (in/out)
- **Do NOT write detailed requirements, user stories, or acceptance criteria yet** — those require research input.

**Researcher** writes three files in parallel (spawn 3 researcher subagents with `run_in_background: true`):
- `research/competitors.md` — How competitors solve this problem. Strengths, weaknesses, UX approach, market gaps.
- `research/technology.md` — Best practices, industry standards, latest trends, emerging patterns, technology capabilities that could enable better solutions.
- `research/user-sentiment.md` — What users love/hate about existing solutions. Reviews, forums, social media, pain points, unmet needs.

**Wait for ALL research to complete before proceeding.** Product cannot write specs without research.

After all finish, **challenger** reviews initiative framing and all research outputs — questions assumptions, identifies missing angles, challenges scope, flags research bias.

**If challenger verdict is BLOCKED:** Present critical issues to user. User decides: address and re-run, override, or abandon.
**If PASS WITH CONDITIONS:** Product/researcher address major issues before proceeding.

**Gate:** Present initiative + research with challenger's input. "Approve to proceed to Spec & Plan?"

## Stage 2: Spec & Plan

**IMPORTANT:** This stage requires completed research from Stage 1. Product and architect must reference `research/competitors.md`, `research/technology.md`, and `research/user-sentiment.md` when writing specs.

Run in parallel:

**Product** and **designer** collaborate:
- Refine `product/{feature-name}.md` — NOW add detailed requirements, user stories, and acceptance criteria informed by research findings. Reference specific insights from competitor analysis, user sentiment, and technology capabilities.
- Write `product/prd.md` — detailed spec with acceptance criteria, interaction specs, UX flows, and technical approach. Every requirement should trace to a research insight or user need.

**Architect** owns `engineering/plan.md` — implementation plan with architecture decisions, ordered steps with file references, data model changes. **Api** provides API contracts, endpoints, and request/response schemas — architect incorporates them into the plan.

After all finish, **challenger** reviews PRD, design, and plan — questions UX decisions, tech choices, scope creep, identifies risks before committing to test writing and build.

**If challenger verdict is BLOCKED:** Present critical issues to user. User decides: fix and re-challenge, override, or abandon.
**If PASS WITH CONDITIONS:** Respective agents address major issues before proceeding.

**Gate:** Present PRD + design + plan with challenger's concerns addressed. "Approve to proceed?"

## Stage 3: Test (spec-based, BEFORE build)

**Spawn: eng-testing** → Write tests based on:
- PRD acceptance criteria from `product/prd.md`
- Architecture plan from `engineering/plan.md`
- API contracts from the architect's plan

The tester writes tests that define expected behavior — what the code SHOULD do — without seeing any implementation. Tests go in `tests/` within the initiative folder as spec references, and in the appropriate test directories in the codebase.

**These tests will fail initially — that's expected.** They define the target. Engineers will build to make them pass.

**What to test from specs:**
- Each acceptance criterion from the PRD becomes at least one test case
- Each API endpoint gets request/response validation tests
- Each user story gets a behavioral test
- Edge cases identified in the PRD and architecture plan
- Error states and boundary conditions from the spec

## Stage 4: Build (Team Phase)

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

## Stage 5: Validate

Run in parallel:

**Run pre-written tests** against the built code. These are the tests from Stage 3 — they were written from specs, not from the implementation.

**Challenger** reviews implementation — missed edge cases, unnecessary complexity, spec deviations, integration risks.

**If tests fail:** Spawn appropriate engineering agent(s) to fix. Re-run tests until passing. Track which tests failed and why — this reveals where the implementation deviated from the spec.

**If challenger verdict is BLOCKED:** Present critical issues to user. User decides: fix, override, or proceed to review.
**If PASS WITH CONDITIONS:** Spawn appropriate agent(s) to address major issues.

**Gate:** All tests passing.

## Stage 6: Review

```
TeamCreate("review-{feature-slug}")
```

Spawn all reviewers as a team for parallel review:

1. **spec-reviewer** (reviewer-code): Spec alignment — verifies implementation against `product/prd.md` and `engineering/plan.md`
2. **func-reviewer** (reviewer-code): Functional — correctness, edge cases, error handling
3. **quality-reviewer** (reviewer-code): Quality — code patterns, performance, security
4. **arch-reviewer** (reviewer-architecture): Compliance — architecture fit, scalability, accessibility, i18n

Each reviewer receives context from prior rounds via the shared task list.

**You (lead):** Compile findings into `review-report.md` in the initiative root. Include spec coverage %, issues by severity, merge readiness. Clean up the team.

**Gate:** Present review report to user. Final approval.

## Deliverables

```
initiatives/{feature-name}-YYYY-MM-DD/
├── product/
│   ├── {feature-name}.md       # Initiative overview + detailed requirements
│   └── prd.md                  # Detailed spec with acceptance criteria
├── engineering/
│   └── plan.md                 # Implementation plan with file references
├── research/
│   ├── competitors.md          # Competitive analysis
│   ├── technology.md           # Tech trends, best practices, capabilities
│   └── user-sentiment.md       # User reviews, forums, social media insights
├── tests/                      # Spec-based test references
└── review-report.md            # Final review findings
```

Plus: working implementation with passing tests in the codebase.
