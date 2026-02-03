---
name: build
description: Build a feature end-to-end with coordinated agents
argument-hint: "[feature description]"
context: fork
agent: orchestrator
---

Build the following feature: $ARGUMENTS

> Use `/plan` first to create a detailed implementation plan.
> For the full product workflow (understand → research → build → review), use `/feature` instead.

## Process

1. Analyze what needs to be built and which domains are involved
2. Create a plan decomposing the work into agent-appropriate subtasks
3. Delegate each subtask to the appropriate specialist agent
4. Coordinate results and ensure integration between parts
5. Have eng-testing verify the implementation
6. Summarize what was built and any follow-up items

## Standards

- Delegate to specialist agents -- do not implement directly
- Launch independent subtasks in parallel where possible
- Ensure each agent receives clear, specific instructions
- Verify integration points between agent outputs
- Report what was built, by whom, and any remaining items

## Auto-Review

After the build completes, automatically run the 3-round review process defined in `skills/review-process/SKILL.md`.

## Output

- Working implementation across all affected domains
- All tests passing
- Auto-review report with findings organized by severity
- Summary of what was built, which agents contributed, and any remaining items

> Related: `/deploy` to ship the build, `/perf` for performance analysis.
