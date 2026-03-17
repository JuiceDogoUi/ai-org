---
name: explore
description: Research an idea from all angles before deciding to build
argument-hint: "[idea, problem, or opportunity to explore]"
user-invocable: true
context: fork
model: opus
---

# Explore: $ARGUMENTS

You are the team lead coordinating a multi-angle exploration. This is the "should we build this?" command — research first, decide later.

## Team

Spawn in Stage 1:
- **product** (product-lead): Captures the initiative and decision criteria

Spawn in Stage 2 (parallel):
- **researcher** (researcher): Three parallel research streams
- **challenger** (challenger): Reviews synthesis, challenges conclusions

**If an agent doesn't exist:** Handle that task directly using the same approach.

## Folder Structure

Use ISO date format: `initiatives/{idea-slug}-exploration-YYYY-MM-DD/`

Check if an exploration folder already exists for this idea. If it does, read existing artifacts — skip research that's already done unless the scope has changed.

Create folder structure (if it doesn't exist):
```
initiatives/{idea-slug}-exploration-YYYY-MM-DD/
├── product/
└── research/
```

## Stage 1: Understand

**You (lead):** Ask the user these questions (skip any already answered in $ARGUMENTS):

1. What's the idea? (problem, opportunity, or hunch)
2. What triggered this? (user request, competitor move, data, intuition)
3. What do you already know? (existing research, assumptions, constraints)
4. What would convince you to build it? (the decision criteria)

Wait for answers before proceeding.

**Spawn: product-lead** → Write `product/initiative.md` capturing:
- The idea and its origin
- What's already known vs. what needs research
- Decision criteria — what the research must answer

**Gate:** Present to user. "Approve to proceed to Research?"

## Stage 2: Research (parallel, then synthesis)

Spawn 2a–2c in parallel using `run_in_background: true`, wait for all three to complete, then run 2d–2e sequentially.

### 2a. Market & User Sentiment

**Spawn: researcher** → Write to `research/market.md`:
- **Market opportunity** — is there demand? what trends support this?
- **User sentiment** — what are people saying? pain points, workarounds, requests
- **Demand signals** — search volume, forum activity, feature requests, support tickets

### 2b. Competitors

**Spawn: researcher** → Write to `research/competitors.md`:
- **Competitor landscape** — who solves this today? how? what's their approach?
- **Gaps** — what do existing solutions miss? where's the white space?
- **Positioning opportunity** — how would we differentiate?

### 2c. Technical Feasibility

**Spawn: eng-architect** → Write to `research/technical.md`:
- **Feasibility** — can we build this with our current stack?
- **Complexity** — what's the effort? what are the hard parts?
- **Approaches** — what are the main technical options? trade-offs?
- **Dependencies** — what do we need that we don't have?
- **Risks** — what could go wrong technically?

Read the codebase to assess current architecture.

### 2d. Synthesis

**Spawn: product-lead** → Read all research, write `research/synthesis.md`:
- **Opportunity score** — strong / moderate / weak
- **Key insight** — the one thing that changes the decision
- **Risks summary** — top 3 risks across all angles
- **Recommendation** — build, pivot, park, or kill — with reasoning

### 2e. Challenge

**Spawn: challenger** → Review all research and synthesis:
- Questions the recommendation
- Identifies research gaps or bias
- Challenges assumptions about feasibility, demand, or differentiation
- Flags what would change the recommendation

**If challenger verdict is BLOCKED:** Present critical issues to user. User decides: re-run specific research angles, override, or abandon.
**If PASS WITH CONDITIONS:** Note major concerns prominently in the final report.

## Final Report

**You (lead):** Compile research + challenger input into a single report for the user:

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

### Challenger Perspective
{Key concerns and what would change the recommendation}

### Recommendation
{build / pivot / park / kill} — {reasoning}

### Next Steps
{- build → "Use `/feature {idea}` to start the full workflow"}
{- pivot → what angle to explore differently}
{- park → what signal to watch for before revisiting}
{- kill → why, and what to pursue instead}
```

Present to user.

> Related: `/feature` to start the full workflow if the recommendation is "build".
