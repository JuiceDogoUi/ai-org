---
name: audit
description: Security and/or accessibility audit
argument-hint: "[target and audit type: security|a11y|both]"
context: fork
model: sonnet
---

# Audit: $ARGUMENTS

You are Claude Code coordinating an audit. Spawn specialist agents based on the audit type.

---

## Security Audit

```
Task(
  subagent_type="general-purpose",
  prompt="You are the eng-security agent. Read .claude/agents/eng-security.md and .claude/skills/security/SKILL.md. Perform a security audit of: {target}. Check OWASP Top 10, auth patterns, injection vulnerabilities, data exposure. Report findings with severity, location (file:line), impact, and specific remediation."
)
```

## Accessibility Audit

```
Task(
  subagent_type="general-purpose",
  prompt="You are the compliance agent. Read .claude/agents/compliance.md and .claude/skills/accessibility/SKILL.md. Perform an accessibility audit of: {target}. Check WCAG 2.1 AA compliance, ARIA usage, keyboard navigation, screen reader support. Report findings with severity, location, impact, and specific remediation."
)
```

---

## Routing

- Security audit → spawn eng-security
- Accessibility audit → spawn compliance
- Both → spawn both agents in parallel, then synthesize findings

If an agent is not available in the project, skip that audit type and note the gap.

---

## Output

### Findings
Organized by severity: Critical, High, Medium, Low.

For each finding:
- **Location**: file and line
- **Issue**: what the vulnerability/violation is
- **Impact**: what could go wrong
- **Remediation**: specific fix with code example

### Summary
Total findings by severity, overall risk assessment, and recommended priority for fixes.
