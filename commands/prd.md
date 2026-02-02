---
name: prd
description: Generate a product requirements document
argument-hint: "[feature or product name]"
context: fork
agent: product-manager
---

Write a Product Requirements Document for: $ARGUMENTS

## Process

1. **Discover**: Ask clarifying questions — who is the user, what problem are they facing, what's the business context?
2. **Research**: Read existing strategy docs (strategy/foundation/personas.md, strategy/foundation/positioning.md), search codebase for related features
3. **Draft**: Write the PRD using the sections below
4. **Validate**: Present to user, incorporate feedback

If strategy/foundation/personas.md exists, reference it for target user context.
If strategy/foundation/positioning.md exists, ensure alignment with product positioning.

## Output

### Problem Statement
What problem are we solving and for whom?

### Goals & Non-Goals
What are we trying to achieve? What is explicitly out of scope?

### User Stories
As a [role], I want [capability], so that [benefit].

### Requirements
- Functional requirements (what the system does)
- Non-functional requirements (performance, security, accessibility)

### Success Metrics
How will we measure success?

### Open Questions
What needs clarification before implementation?

> Related: `/plan` to create an implementation plan from this PRD, `/estimate` to size the work, `/feature` for the full workflow including research and build.
