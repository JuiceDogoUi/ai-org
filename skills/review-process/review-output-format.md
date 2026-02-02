# Review Output Format

Structured output template for review findings across all three rounds.

## Severity Classification

Every finding must be classified into one of three severity levels:

| Severity | Criteria | Gate |
|----------|----------|------|
| **Critical** | Will cause a bug, security vulnerability, or data loss at runtime | Must fix before merge |
| **Warning** | May cause problems over time — code smell, performance degradation, maintainability risk | Should fix before merge |
| **Suggestion** | Improvement to quality — readability, performance, maintainability, consistency | Consider improving |

### Classification Rules

- If it can cause **incorrect behavior in production** → Critical
- If it creates a **security vulnerability** (injection, auth bypass, data exposure) → Critical
- If it can cause **data loss or corruption** → Critical
- If it violates a **project convention** consistently → Warning
- If it introduces **technical debt** that will compound → Warning
- If it degrades **performance measurably** → Warning
- If it could be **more readable, idiomatic, or efficient** → Suggestion
- If it's a **style preference** already handled by linters → Do not report

## Finding Format

Each individual finding should follow this structure:

```
### [Severity]: [Brief title]

**Location**: `file/path.ts:42`
**Issue**: [What the problem is — be specific]
**Why**: [Why it matters — what could go wrong, what principle it violates]
**Fix**: [Specific recommended change — show code if helpful]
```

Example:

```
### Critical: SQL injection in user search

**Location**: `src/routes/users.ts:87`
**Issue**: User input is interpolated directly into SQL query string
**Why**: Allows arbitrary SQL execution — attacker can read/modify/delete database contents
**Fix**: Use parameterized query:
  `db.query('SELECT * FROM users WHERE name = $1', [searchTerm])`
```

## Summary Format

At the end of the review, include a consolidated summary:

```
## Review Summary

**Result**: PASS / FAIL (fail if any Critical findings exist)

### Findings by Severity
- Critical: {count}
- Warning: {count}
- Suggestion: {count}

### By Round
- Round 1 (Functional): {count} findings
- Round 2 (Quality): {count} findings
- Round 3 (Compliance): {count} findings

### Overall Assessment
{2-3 sentence summary of the change quality, key risks, and overall recommendation}

### Recommended Action
- [ ] Fix {N} critical issues before merge
- [ ] Address {N} warnings in this PR or follow-up
- [ ] Consider {N} suggestions for future improvement
```

## Organizing Multi-Round Output

When presenting findings from all three rounds together:

1. **Lead with the summary** — pass/fail and finding counts
2. **Group by severity** (Critical first, then Warning, then Suggestion) — not by round
3. **Tag each finding with its round** for context: `[Round 1]`, `[Round 2]`, `[Round 3]`
4. **De-duplicate** — if the same issue is caught by multiple reviewers, combine into one finding
5. **End with the action checklist** — ordered by priority
