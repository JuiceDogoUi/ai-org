---
name: build
description: Build a feature end-to-end with coordinated agents
argument-hint: "[feature description]"
context: fork
agent: orchestrator
---

Build the following feature: $ARGUMENTS

> For the full product workflow (understand → research → build → review), use `/feature` instead.

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

## Auto-Review

After the build completes, automatically run a 3-round review. Skip any agent that is not available in the project.

### Round 1 — Functional

- **eng-testing**: Run tests, verify all pass
- **reviewer-code**: Verify acceptance criteria and code correctness

### Round 2 — Quality

- **reviewer-code**: Full code review (style, patterns, bugs, security)
- **eng-performance** (if available): Performance review
- **reviewer-architecture** (if available): Architecture and component design review

### Round 3 — Compliance

- **compliance** (if available): GDPR and WCAG compliance check
- **reviewer-content** (if available): SEO and schema review
- **positioning** (if available): Verify alignment with product positioning and guidelines

### Auto-Review Output

Organize feedback by severity:

#### Critical (must fix before merge)
Issues that will cause bugs, security vulnerabilities, or data loss.

#### Warning (should fix)
Issues that may cause problems or degrade quality over time.

#### Suggestion (consider improving)
Improvements to readability, performance, or maintainability.

For each finding include:
- **File:line** — exact location
- **Issue** — what the problem is
- **Why** — why it matters
- **Fix** — specific recommended change

#### Summary

Consolidated summary across all three rounds with overall assessment.
