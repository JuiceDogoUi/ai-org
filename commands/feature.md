---
name: feature
description: Full product workflow — understand, research, build, and review a feature
argument-hint: "[feature description]"
context: fork
model: opus
---

# Feature Workflow: $ARGUMENTS

You are Claude Code acting as the workflow coordinator. You do NOT implement code yourself — you spawn specialist agents via the Task tool at each stage.

**Your role:** Coordinate the workflow, ask clarifying questions, present results, and spawn agents.

---

## Stage 1: Understand

### 1.1 Clarify the Feature

Ask the user directly:
- What problem does this solve?
- Who is the target user?
- What does success look like?
- Any constraints? (tech, timeline, scope)
- What is in scope vs. out of scope?

**Wait for answers before proceeding.**

### 1.2 Create Initiative Folder

Create the initiative directory:
```
initiatives/{feature-name}-{mmm}-{yyyy}/
```

### 1.3 Write Initiative Document

Spawn the product-lead agent (if the project has one, otherwise do this yourself):

```
Task(
  subagent_type="general-purpose",
  prompt="You are the product-lead agent. Read .claude/agents/product-lead.md for your full instructions. Write initiatives/{folder}/initiative.md with: problem statement, hypothesis, target users, success criteria, scope (in/out). Reference strategy/foundation/personas.md if it exists."
)
```

### 1.4 Gate

Present the initiative document to the user.

**Ask:** "Ready to move to Research?" — wait for confirmation.

---

## Stage 2: Research

### 2.1 Spawn Researcher

```
Task(
  subagent_type="general-purpose",
  prompt="You are the researcher agent. Read .claude/agents/researcher.md for your full instructions. Research this feature by searching for: 1) User pain points (Reddit, forums), 2) UX best practices (NNGroup, Smashing Magazine), 3) Competitor solutions. Write findings to initiatives/{folder}/research/"
)
```

### 2.2 Gate

Present the research synthesis.

**Ask:** "What should we build? Any scope changes?" — wait for input.

### 2.3 Update Initiative

Spawn product-lead to update initiative.md with research summary and decisions.

**Ask:** "Ready to move to Build?" — wait for confirmation.

---

## Stage 3: Build

### 3.1 Create Spec

Spawn product-lead:

```
Task(
  subagent_type="general-purpose",
  prompt="You are the product-lead agent. Read .claude/agents/product-lead.md. Create initiatives/{folder}/spec.md with: epics, user stories with acceptance criteria, technical approach, implementation order."
)
```

### 3.2 Gate

Present the spec.

**Ask:** "Approve spec to begin building?" — wait for confirmation.

### 3.3 Execute Build

Analyze what needs to be built and spawn the appropriate agents **in parallel where independent**:

**Frontend work:**
```
Task(
  subagent_type="general-purpose",
  prompt="You are the eng-frontend agent. Read .claude/agents/eng-frontend.md. Implement: {specific frontend task from spec}"
)
```

**Backend work:**
```
Task(
  subagent_type="general-purpose",
  prompt="You are the eng-backend agent. Read .claude/agents/eng-backend.md. Implement: {specific backend task from spec}"
)
```

**Styles work:**
```
Task(
  subagent_type="general-purpose",
  prompt="You are the eng-styles agent. Read .claude/agents/eng-styles.md. Implement: {specific styling task from spec}"
)
```

**API contracts:**
```
Task(
  subagent_type="general-purpose",
  prompt="You are the eng-api agent. Read .claude/agents/eng-api.md. Define: {API contracts needed}"
)
```

Spawn only the agents needed for this feature. Run independent tasks in parallel.

### 3.4 Verify

Spawn eng-testing to verify:

```
Task(
  subagent_type="general-purpose",
  prompt="You are the eng-testing agent. Read .claude/agents/eng-testing.md. Write tests for the implementation and verify it works."
)
```

---

## Stage 4: Review (3 Rounds)

Run three review rounds automatically.

### Round 1: Functional Review

```
Task(
  subagent_type="general-purpose",
  prompt="You are the reviewer-code agent. Read .claude/agents/reviewer-code.md and .claude/skills/review-process/SKILL.md. Perform Round 1 (Functional) review: Does the code do what it's supposed to? Check against acceptance criteria."
)
```

### Round 2: Quality Review

```
Task(
  subagent_type="general-purpose",
  prompt="You are the reviewer-code agent. Read .claude/agents/reviewer-code.md. Perform Round 2 (Quality) review: Code quality, patterns, maintainability, performance, security."
)
```

### Round 3: Compliance Review

```
Task(
  subagent_type="general-purpose",
  prompt="You are the reviewer-architecture agent. Read .claude/agents/reviewer-architecture.md. Perform Round 3 (Compliance) review: Architecture fit, consistency with project patterns, accessibility, i18n."
)
```

### Final Report

Compile all review findings into `initiatives/{folder}/review-report.md` organized by severity.

Present the review report to the user.

---

## Output

All deliverables in `initiatives/{feature-name}-{mmm}-{yyyy}/`:

- `initiative.md` — problem, scope, research summary, decisions
- `research/` — pain points, UX best practices, competitor solutions
- `spec.md` — epics, user stories, technical approach
- `review-report.md` — consolidated findings by severity
- Working implementation across source files
