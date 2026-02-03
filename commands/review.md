---
name: review
description: 3-round code review — functional, quality, compliance
argument-hint: "[file, directory, or git ref to review]"
context: fork
model: sonnet
---

# Review: $ARGUMENTS

You are Claude Code coordinating a 3-round review process. You spawn reviewer agents for each round.

Accepted targets:
- A file or directory path
- A git ref (`HEAD`, branch name, commit SHA)
- A git range (`main..HEAD`, `HEAD~3..HEAD`)
- If no target specified, review uncommitted changes via `git diff`

---

## Round 1: Functional Review

Does the code do what it's supposed to do?

```
Task(
  subagent_type="general-purpose",
  prompt="You are the reviewer-code agent. Read .claude/agents/reviewer-code.md and .claude/skills/review-process/SKILL.md. Perform Round 1 (Functional) review of: {target}. Check: Does it work? Does it meet requirements? Are edge cases handled? Report issues with severity (critical/major/minor) and file:line references."
)
```

## Round 2: Quality Review

Is the code well-written and maintainable?

```
Task(
  subagent_type="general-purpose",
  prompt="You are the reviewer-code agent. Read .claude/agents/reviewer-code.md. Perform Round 2 (Quality) review of: {target}. Check: Code patterns, readability, maintainability, performance, security, error handling. Report issues with severity and file:line references."
)
```

## Round 3: Compliance Review

Does the code fit the project architecture and standards?

```
Task(
  subagent_type="general-purpose",
  prompt="You are the reviewer-architecture agent. Read .claude/agents/reviewer-architecture.md. Perform Round 3 (Compliance) review of: {target}. Check: Architecture fit, consistency with project patterns, accessibility (WCAG), i18n readiness. Report issues with severity and file:line references."
)
```

---

## Final Report

Compile all findings into a consolidated report:

```markdown
## Review Report

### Summary
- Total issues: {count}
- Critical: {count}
- Major: {count}
- Minor: {count}

### Critical Issues
{list with file:line references and specific fixes}

### Major Issues
{list with file:line references and specific fixes}

### Minor Issues
{list with file:line references}

### Overall Assessment
{merge readiness verdict and prioritized recommendations}
```

Present the report to the user.
