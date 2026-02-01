---
name: build
description: Build a feature end-to-end with coordinated agents
argument-hint: "[feature description]"
context: fork
agent: orchestrator
---

Build the following feature: $ARGUMENTS

## Orchestration Workflow

1. Analyze what needs to be built and which domains are involved
2. Create a plan decomposing the work into agent-appropriate subtasks
3. Delegate each subtask to the appropriate specialist agent
4. Coordinate results and ensure integration between parts
5. Have the testing agent verify the implementation
6. Summarize what was built and any follow-up items

## Rules

- Delegate to specialist agents -- do not implement directly
- Launch independent subtasks in parallel where possible
- Ensure each agent receives clear, specific instructions
- Verify integration points between agent outputs
- Report what was built, by whom, and any remaining items
