---
name: product-management
description: PRD frameworks, user stories, prioritization, and roadmapping. Use when writing requirements, planning features, or prioritizing work.
user-invocable: false
---

# Product Management

> **Documentation Freshness**: Prioritization frameworks and PRD conventions are
> well-established, but tooling and team practices evolve. Adapt frameworks to
> your team's workflow rather than following templates rigidly.

## File Guide
- **prd-template.md** — Fill-in PRD template with problem statement, requirements, and success metrics
- **user-stories.md** — User story format, Given-When-Then acceptance criteria, and splitting patterns

## PRD Structure

1. **Problem statement** — Who has the problem, what is it, how painful is it
2. **Goals and non-goals** — What success looks like, what's explicitly out of scope
3. **User stories** — Who does what and why
4. **Requirements** — Functional and non-functional
5. **Success metrics** — How we measure success
6. **Open questions** — Unresolved decisions

## User Stories

"As a [role], I want [capability], so that [benefit]." See **user-stories.md** for the full format, Given-When-Then acceptance criteria, examples, and story splitting patterns.

## Prioritization Frameworks

### MoSCoW
- **Must have** — Core functionality, blocking issues, legal requirements
- **Should have** — Important but not blocking
- **Could have** — Nice to have, do if time allows
- **Won't have** — Explicitly out of scope for this release

### RICE
- **Reach** — How many users affected
- **Impact** — How much it moves the metric (1-3 scale)
- **Confidence** — How sure are we (percentage)
- **Effort** — Person-weeks to complete
- Score = (Reach × Impact × Confidence) / Effort

### Impact/Effort Matrix
- **Quick wins** — High impact, low effort (do first)
- **Big bets** — High impact, high effort (plan carefully)
- **Fill-ins** — Low impact, low effort (do when convenient)
- **Money pits** — Low impact, high effort (avoid)

### Kano Model
- **Basic** — Expected, causes dissatisfaction if missing
- **Performance** — More is better, linear satisfaction
- **Delighter** — Unexpected, causes satisfaction if present

## Roadmapping

### Time Horizons
- **Now** — Currently in progress, committed work
- **Next** — Planned for upcoming cycles, high confidence
- **Later** — Future intentions, subject to change

### Roadmap Elements
- Theme or initiative (not feature list)
- Problem being solved
- Success metric
- Dependencies
- Rough timeline (quarter, not specific dates)

### Avoid
- Date commitments you can't keep
- Feature-level detail beyond current cycle
- Treating roadmap as contract vs. communication tool

## Metrics

### Types
- **Input metrics** — Actions you control (features shipped, experiments run)
- **Output metrics** — Results you influence (conversion, retention)
- **Guardrail metrics** — Things that shouldn't break (performance, error rate)

### Good Metrics Are
- Measurable with available data
- Actionable — you can influence them
- Comparable over time
- Not easily gamed

## Stakeholder Communication

### Status Updates
- What was accomplished
- What's planned next
- What's blocked or at risk
- What decisions are needed

### Saying No
- Acknowledge the request's value
- Explain what would need to change to say yes
- Offer alternatives or future consideration
- Document the decision

## Avoid

- **Feature factories** — Shipping features without validating impact
- **HIPPO decisions** — Highest paid person's opinion overriding data
- **Scope creep** — Requirements expanding without conscious tradeoffs
- **Requirements as solutions** — "Add a modal" vs. "User needs to confirm"
- **Vanity metrics** — Numbers that look good but don't drive value
- **Roadmaps as commitments** — Communicating plans as promises
