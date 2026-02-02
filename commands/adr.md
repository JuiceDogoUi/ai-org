---
name: adr
description: Create an Architecture Decision Record
argument-hint: "[decision title]"
context: fork
agent: orchestrator
---

Create an Architecture Decision Record for: $ARGUMENTS

## Process

1. **Analyze**: Delegate to reviewer-architecture (if available, otherwise reviewer-code) to analyze the current architecture and identify constraints, trade-offs, and affected systems
2. **Research alternatives**: Investigate at least 3 approaches — evaluate each on complexity, maintainability, performance, and team familiarity
3. **Decide**: Synthesize analysis into a recommendation with clear rationale
4. **Document**: Delegate to writer-technical to write the ADR in the format below

If the decision involves frontend architecture → also consult eng-frontend context.
If the decision involves data/persistence → also consult eng-database context.

## Output

### Title
Short descriptive title of the decision.

### Status
Proposed | Accepted | Deprecated | Superseded

### Context
What is the situation that requires a decision? What forces are at play?

### Decision
What is the change we are proposing or have agreed to?

### Consequences
- **Positive**: What becomes easier?
- **Negative**: What becomes harder?
- **Neutral**: What other changes are required?

### Alternatives Considered
What other options were evaluated and why were they rejected?

> Related: `/research` to investigate alternatives before deciding, `/plan` to plan implementation after the decision.
