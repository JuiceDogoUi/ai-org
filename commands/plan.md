---
name: plan
description: Create an implementation plan for a feature or task
argument-hint: "[feature or task description]"
context: fork
agent: orchestrator
---

Create a detailed implementation plan for: $ARGUMENTS

> After planning, use `/build` to implement, `/estimate` to size the work, or `/feature` for the full workflow (understand → research → build → review).

## Process

1. Research the existing codebase to understand current architecture
2. Identify affected files and systems
3. Break down into ordered implementation steps
4. Flag risks and dependencies
5. Identify open questions

## Output

### Overview
Brief summary of the task and approach.

### Affected Systems
List of files, modules, and systems that will be touched.

### Implementation Steps
Ordered list of concrete steps with file references.

### Risks & Dependencies
What could go wrong, what depends on what.

### Open Questions
Anything that needs clarification before starting.
