---
name: feature
description: Full product workflow — understand, research, build, and review a feature
argument-hint: "[feature description]"
context: fork
agent: orchestrator
---

Run the full feature workflow for: $ARGUMENTS

You MUST follow these four stages in order. Each stage has gates that require user confirmation before proceeding.

## Stage 1: Understand

### 1.1 Clarify the Feature

Ask the user clarifying questions:
- What problem does this solve?
- Who is the target user?
- What does success look like? (success criteria)
- Any constraints? (tech, timeline, scope)
- What is in scope vs. out of scope?

Wait for answers before proceeding.

### 1.2 Create Initiative Folder

Create the initiative directory. Use kebab-case for the feature name and lowercase month abbreviation:

```
initiatives/{feature-name}-{mmm}-{yyyy}/
```

### 1.3 Write Initiative Document

Delegate to **product-lead** (if available, otherwise orchestrator) to write `initiative.md` inside the initiative folder created in step 1.2. Contents:
- Problem statement
- Hypothesis
- Target users
- Success criteria
- Scope (in/out)
- Agents and skills plan (which agents will be involved)

If `strategy/foundation/personas.md` exists, reference it for user context.

### 1.4 Present and Gate

Present the initiative document to the user.

**Gate**: Ask "Ready to move to Research?" — wait for confirmation before proceeding.

## Stage 2: Research

### 2.1 Parallel Research

Delegate to **researcher** (if available) to run 3 parallel WebSearch tasks. If the researcher agent is not available, the orchestrator performs the research directly.

1. **Pain points** — Search Reddit, X/Twitter, Hacker News, and forums for user pain points related to this feature area. Write findings to `research/pain-points.md`
2. **UX best practices** — Search NNGroup, Smashing Magazine, and similar sources for UX patterns. Write findings to `research/ux-best-practices.md`
3. **Competitor solutions** — Search for how competitors solve this problem. Write findings to `research/competitor-solutions.md`

All paths are relative to the initiative folder.

**Fallback**: If web search is unavailable, research from existing project files, strategy documents, and codebase patterns instead.

### 2.2 Synthesize

Delegate to **researcher** (if available, otherwise orchestrator) to synthesize the three research documents into a summary covering:
- Top pain points
- Recommended UX patterns
- Competitor approaches
- Overall recommendation

### 2.3 Scope Gate

**Gate**: Present the synthesis and ask "What should we build? Any scope changes?" — wait for user input.

### 2.4 Update Initiative

Delegate to **product-lead** (if available, otherwise orchestrator) to update `initiative.md` with:
- Research summary
- Decisions log (what was decided based on research)

**Gate**: Ask "Ready to move to Build?" — wait for confirmation.

## Stage 3: Build

### 3.1 Create Spec

Delegate to **product-lead** (if available, otherwise orchestrator) to create `spec.md` in the initiative folder containing:
- Epics
- User stories with acceptance criteria
- Technical approach
- Implementation order with agent assignments

### 3.2 Spec Approval Gate

**Gate**: Present the spec and ask "Approve spec to begin building?" — wait for confirmation.

### 3.3 Execute Build

Execute the build:
1. Analyze which domains are involved
2. Decompose work into agent-appropriate subtasks
3. Delegate to specialist agents (eng-frontend, eng-backend, eng-api, etc.) in parallel where possible
4. Coordinate results and ensure integration between parts
5. Have **eng-testing** verify the implementation

### 3.4 Report and Continue

Report what was built. Auto-trigger Stage 4 (no gate).

## Stage 4: Review (3 Automatic Rounds)

Run three review rounds automatically without user gates between them. Follow the 3-round review process defined in `skills/review-process/SKILL.md`.

Write `review-report.md` in the initiative folder with consolidated findings from all three rounds.

Present the review report to the user.

## Output

All deliverables are written to the initiative folder (`initiatives/{feature-name}-{mmm}-{yyyy}/`):

- `initiative.md` — problem statement, scope, research summary, decisions log
- `research/` — pain points, UX best practices, competitor solutions
- `spec.md` — epics, user stories with acceptance criteria, technical approach
- `review-report.md` — consolidated review findings by severity
- Working implementation across all affected source files

> Related: `/plan` to plan without building, `/build` to build without the full workflow, `/review` for standalone review.
