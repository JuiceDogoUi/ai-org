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

Use the Task tool. Spawn each agent by name (e.g., `product-lead`, `eng-frontend`).

Pass context between stages:
- Feature name and description
- Initiative folder path
- Relevant outputs from previous stages

**If an agent doesn't exist:** Handle that task directly using the same approach.

---

## Stage 1: Understand

**You (Claude Code):**
1. Ask the user: What problem? Who is the user? What does success look like? In/out of scope?
2. Wait for answers
3. Create folder: `initiatives/{feature-name}-{date}/`

**Spawn: product-lead** → Write `initiative.md` with user's answers

**Gate:** Present to user. "Approve to proceed to Research?"

---

## Stage 2: Research

**Spawn: researcher** → Research the feature, write to `research/`

**You (Claude Code):** Present findings. Ask about scope changes.

**Spawn: product-lead** → Update `initiative.md` with research summary

**Gate:** "Approve to proceed to Build?"

---

## Stage 3: Build

**Spawn: product-lead** → Create `spec.md` with user stories and technical approach

**Gate:** Present spec. "Approve to start building?"

**You (Claude Code):** Analyze spec, spawn only the agents needed (if they exist):
- UI work → **eng-frontend**
- Backend/DB → **eng-backend**
- Styling → **eng-styles**
- API contracts → **eng-api**

Spawn independent tasks in parallel.

**Spawn: eng-testing** → Write tests, verify implementation

---

## Stage 4: Review

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
