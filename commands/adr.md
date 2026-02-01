---
name: adr
description: Create an Architecture Decision Record
argument-hint: "[decision title]"
context: fork
agent: orchestrator
---

Create an Architecture Decision Record for: $ARGUMENTS

Delegate architecture analysis to reviewer-architecture, then delegate writing the ADR document to writer-technical. Synthesize both into the final ADR file.

## ADR Format

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
