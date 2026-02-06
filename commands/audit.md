---
name: audit
description: Security and/or accessibility audit
argument-hint: "[target and audit type: security|a11y|both]"
user-invocable: true
context: fork
model: sonnet
---

# Audit: $ARGUMENTS

You are Claude Code coordinating an audit.

## How to Spawn Agents

Use the Task tool. Spawn each agent by name (e.g., `eng-security`, `compliance`).

**If an agent doesn't exist:** Handle that task directly using the same approach.

---

## Routing

Based on audit type requested:

- **Security** → Spawn: eng-security
- **Accessibility** → Spawn: compliance
- **Both** → Spawn both in parallel, then synthesize

---

## Security Audit

**Spawn: eng-security** → OWASP Top 10, auth patterns, injection vulnerabilities, data exposure

---

## Accessibility Audit

**Spawn: compliance** → WCAG 2.1 AA, ARIA usage, keyboard navigation, screen reader support

---

## Final Report

**You (Claude Code):** Compile findings organized by severity (Critical, High, Medium, Low).

For each finding:
- Location (file:line)
- Issue description
- Impact
- Remediation

Present summary with total findings and risk assessment.
