---
name: audit
description: Security and/or accessibility audit
argument-hint: "[target and audit type: security|a11y|both]"
context: fork
agent: orchestrator
---

Perform an audit on: $ARGUMENTS

## Routing

- Security audit → delegate to eng-security agent
- Accessibility audit → delegate to compliance agent
- Both → coordinate both agents and synthesize findings

Skip any agent that is not available in the project. If only one audit type is possible (because the other agent is missing), run that one and note the gap.

## Output

### Findings
Organized by severity: Critical, High, Medium, Low.

For each finding:
- **Location**: file and line
- **Issue**: what the vulnerability/violation is
- **Impact**: what could go wrong
- **Remediation**: specific fix with code example

### Summary
Total findings by severity, overall risk assessment, and recommended priority order for fixes.

> Related: `/review` for a general code review, `/refactor` to fix issues found during the audit.
