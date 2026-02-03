---
name: build
description: Build a feature end-to-end with coordinated agents
argument-hint: "[feature description]"
context: fork
agent: orchestrator
---

Build the following feature: $ARGUMENTS

**CRITICAL INSTRUCTIONS:**
- Do NOT use Claude Code's native plan mode (EnterPlanMode tool)
- Do NOT implement code yourself — ALWAYS delegate to specialist agents using the Task tool
- You are the ORCHESTRATOR — you coordinate, you do NOT implement

> Use `/plan` first to create a detailed implementation plan.
> For the full product workflow (understand → research → build → review), use `/feature` instead.

## Process

1. Analyze what needs to be built and which domains are involved
2. Create a brief plan decomposing the work into agent-appropriate subtasks
3. **Use the Task tool** to delegate each subtask to the appropriate specialist agent:
   ```
   Task(subagent_type="general-purpose", prompt="You are the {agent-name} agent. Read .claude/agents/{agent-name}.md for your instructions. Then implement: {specific task}")
   ```
4. Run independent subtasks in parallel where possible
5. Coordinate results and ensure integration between parts
6. Delegate to eng-testing to verify the implementation
7. Summarize what was built and any follow-up items

## Standards

- **ALWAYS use Task tool to delegate** — never implement directly
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
