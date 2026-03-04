---
name: explore
description: Research an idea from all angles before deciding to build
argument-hint: "[idea, problem, or opportunity to explore]"
user-invocable: true
context: fork
model: opus
---

# Explore: $ARGUMENTS

You are Claude Code coordinating a multi-angle exploration.
This is the "should we build this?" command — research first, decide later.

## How to Spawn Agents

Use the Task tool. Spawn each agent by name (e.g., `researcher`, `product-lead`).

**If an agent doesn't exist:** Handle that task directly using the same approach.

---

## Stage 1: Understand

**You (Claude Code):** Ask the user these questions (skip any already answered in $ARGUMENTS):

1. What's the idea? (problem, opportunity, or hunch)
2. What triggered this? (user request, competitor move, data, intuition)
3. What do you already know? (existing research, assumptions, constraints)
4. What would convince you to build it? (the decision criteria)

Wait for answers before proceeding.

Create folder: `initiatives/{idea-slug}-exploration-{date}/`

**Spawn: product-lead** → Write `initiative.md` capturing:
- The idea and its origin
- What's already known vs. what needs research
- Decision criteria — what the research must answer

**Gate:** Present to user. "Approve to proceed to Research?"

---

## Stage 2: Research

Four specialists, each owning one angle. Run 2a–2c in parallel, then 2d sequentially.

### 2a. Market & User Sentiment

**Spawn: researcher** → Write to `research/market.md`:
- **Market opportunity** — is there demand? what trends support this?
- **User sentiment** — what are people saying? pain points, workarounds, requests
- **Demand signals** — search volume, forum activity, feature requests, support tickets

Include initiative.md context.

### 2b. Competitors

**Spawn: positioning** → Write to `research/competitors.md`:
- **Competitor landscape** — who solves this today? how? what's their approach?
- **Gaps** — what do existing solutions miss? where's the white space?
- **Positioning opportunity** — how would we differentiate?

Include initiative.md context.

### 2c. Technical Feasibility

**Spawn: eng-architect** → Write to `research/technical.md`:
- **Feasibility** — can we build this with our current stack?
- **Complexity** — what's the effort? what are the hard parts?
- **Approaches** — what are the main technical options? trade-offs?
- **Dependencies** — what do we need that we don't have?
- **Risks** — what could go wrong technically?

Include initiative.md context. Read the codebase to assess current architecture.

### 2d. Synthesis

**Spawn: product-lead** → Read all research, write `research/synthesis.md`:
- **Opportunity score** — is this worth pursuing? (strong / moderate / weak)
- **Key insight** — the one thing that changes the decision
- **Risks summary** — top 3 risks across all angles
- **Recommendation** — build, pivot, park, or kill — with reasoning

Include all prior context (initiative.md, market.md, competitors.md, technical.md).

---

## Final Report

**You (Claude Code):** Compile everything into a single report for the user:

```
## Exploration: {idea name}

### Idea
{1-2 sentence summary of what was explored and why}

### Opportunity
- **Score:** {strong/moderate/weak}
- **Market:** {1-line market summary}
- **Competition:** {who exists, what gap we'd fill}
- **User signal:** {evidence of demand or pain}

### Technical Assessment
- **Feasibility:** {feasible/complex/risky}
- **Effort:** {rough scope: small/medium/large}
- **Key challenge:** {the hardest part}

### Recommendation
{build / pivot / park / kill} — {reasoning}

### Next Steps
{Show only the path matching the recommendation:}
{- build → "Use `/feature {idea}` to start the full workflow"}
{- pivot → what angle to explore differently}
{- park → what signal to watch for before revisiting}
{- kill → why, and what to pursue instead}

### Deliverables
- initiatives/{slug}/initiative.md
- initiatives/{slug}/research/market.md
- initiatives/{slug}/research/competitors.md
- initiatives/{slug}/research/technical.md
- initiatives/{slug}/research/synthesis.md
```

Present to user.
