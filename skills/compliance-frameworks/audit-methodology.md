# Audit Methodology

A structured 4-phase process for conducting compliance audits.

## Phase 1: Scope

Establish what regulations apply before auditing anything.

### Steps:
1. **Read project context** — CLAUDE.md, README, configuration files
2. **Identify jurisdictions**:
   - Where are the users/customers? (determines which privacy laws apply)
   - Where is data stored? (determines data residency requirements)
   - Where does the business operate? (determines local business regulations)
3. **Identify data types processed**:
   - Personal data (names, emails, IPs, device IDs, behavioral data)
   - Financial data (payment cards, bank accounts, transactions)
   - Health data (medical records, health metrics, insurance)
   - Children's data (users under 13 or 16 depending on jurisdiction)
   - Employee data (HR records, payroll)
4. **Identify industry** — healthcare, finance, education, government, e-commerce, SaaS
5. **Map applicable regulations** using the regulatory landscape reference
6. **Research current requirements** from official sources for each applicable regulation
7. **Document scope**: jurisdictions, data types, applicable regulations, audit date

### Scope output:
```
## Audit Scope
- **Project**: {name}
- **Jurisdictions**: {list countries/regions}
- **Data types**: {personal, financial, health, etc.}
- **Industry**: {sector}
- **Applicable regulations**: {list with official source URLs}
- **Audit date**: {date}
- **Auditor**: compliance agent
```

## Phase 2: Codebase Analysis

Systematic analysis of the codebase against each concern area.

### Data flow mapping:
1. Trace how data enters the system (forms, APIs, imports, tracking)
2. Trace where data is stored (databases, caches, cookies, localStorage, files, third-party services)
3. Trace how data is processed (transformations, aggregations, profiling)
4. Trace where data exits (APIs, exports, third-party sharing, emails, logs)
5. Document the complete data flow for each type of personal/sensitive data

### Technical analysis:
- Review authentication and authorization code
- Check encryption implementation (transit and at rest)
- Audit logging configuration (what's logged, what's excluded)
- Review data retention and deletion mechanisms
- Check consent collection and storage
- Scan frontend for accessibility
- Audit dependency licenses
- Check cookie/tracking implementation

## Phase 3: Gap Assessment

For each applicable regulation, compare requirements against implementation.

### Per-finding structure:
```
### [Risk Level]: [Brief title]

**Regulation**: {Regulation name, Article/Section number}
**Requirement**: {What the regulation requires — quote or paraphrase with citation}
**Current state**: {What the codebase currently does or doesn't do}
**Gap**: {Specific difference between requirement and implementation}
**Risk**: {What could happen — enforcement action, data breach, user harm, lawsuit}
**Remediation**: {Specific technical change needed}
**Type**: Regulatory requirement / Best practice / Recommendation
```

### Risk levels:
| Level | Criteria |
|-------|----------|
| Critical | Active violation with enforcement risk, data breach exposure, or user harm |
| High | Gap that would fail a formal audit or creates significant liability |
| Medium | Partial compliance or missing documentation that increases risk |
| Low | Best practice gap or area where compliance could be strengthened |

## Phase 4: Report

### Report structure:

```
# Compliance Audit Report

## Executive Summary
- {2-3 sentences: overall compliance posture, critical findings count, key risk areas}

## Scope
- {From Phase 1}

## Compliance Matrix

| Concern Area | Regulation | Status | Critical | High | Medium | Low |
|-------------|-----------|--------|----------|------|--------|-----|
| Privacy | {reg} | Partial | {n} | {n} | {n} | {n} |
| Accessibility | {standard} | Partial | {n} | {n} | {n} | {n} |
| Data Security | {reg} | Compliant | 0 | 0 | {n} | {n} |
| Licensing | — | Compliant | 0 | 0 | 0 | {n} |

## Findings by Concern Area

### Privacy
{Findings sorted by risk level}

### Accessibility
{Findings sorted by risk level}

### Data Security
{Findings sorted by risk level}

### Licensing
{Findings sorted by risk level}

### Industry-Specific
{If applicable}

## Recommendations
1. {Prioritized list of remediation actions}
2. {Grouped by risk level}
3. {With estimated complexity: simple / moderate / significant}

## Items Flagged for Legal Review
- {Ambiguous areas that need qualified legal counsel}

## Sources Consulted
- {List of official sources with URLs and access dates}

## Limitations
- {What was not covered and why}
- {Assumptions made}
- {This audit is not legal advice}
```

### Key reporting principles:
- Organize by concern area, not by regulation
- Within each concern, sort findings by risk level (critical first)
- Cross-reference when a single gap violates multiple regulations
- Include the compliance matrix for executive overview
- Always include the "not legal advice" disclaimer
- List all official sources consulted
