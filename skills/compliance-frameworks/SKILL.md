---
name: compliance-frameworks
description: Compliance audit methodology, regulatory landscape, and concern-based frameworks for privacy, accessibility, data security, and licensing
user-invocable: false
---

# Compliance Frameworks

> **Documentation Freshness**: Regulations change frequently. Always research current
> requirements from official regulatory body websites before conducting audits.
> Do not rely on this skill alone — verify every requirement against the official
> source for the applicable jurisdiction and version.

A methodology-first approach to regulatory compliance. Regulations vary by jurisdiction, industry, data type, and project scope — this skill teaches how to identify what applies, how to audit against it, and how to report findings. The compliance agent uses web research to pull current, jurisdiction-specific requirements from official sources at audit time.

## File Guide
- **This file** — Concern overview, principles, and common pitfalls
- **concerns.md** — What to audit in each concern area (privacy, data security, licensing, cookies)
- **regulatory-landscape.md** — Regulation map with jurisdictions, applicability, and official sources
- **audit-methodology.md** — 4-phase audit process (scope → analyze → assess → report) with templates
- **gdpr.md** — GDPR quick reference (EU privacy)
- **wcag.md** — WCAG quick reference (accessibility standards and testing)
- **sox.md** — SOX quick reference (US financial reporting IT controls)

## Concern Areas

Compliance work is organized by concern, not by regulation. Each concern may involve multiple regulations depending on jurisdiction:

| Concern | What It Covers | Example Regulations |
|---------|---------------|-------------------|
| Privacy | Personal data collection, processing, storage, deletion, consent, cross-border transfer | GDPR, CCPA/CPRA, PIPEDA, LGPD, APPI, POPIA |
| Accessibility | Digital content usable by people with disabilities | WCAG, ADA, EAA, EN 301 549, Section 508 |
| Data security | Encryption, access control, breach response, audit trails | PCI DSS, SOX, ISO 27001, NIST CSF |
| Licensing | Open-source license compatibility, attribution, copyleft obligations | OSI licenses, FSF guidelines |
| Industry-specific | Domain regulations for health, finance, education, children | HIPAA, PCI DSS, FERPA, COPPA |
| Cookie/tracking consent | User consent for cookies, tracking pixels, analytics | ePrivacy Directive, PECR, CNIL guidance |

See [Concern Details](concerns.md) for what to audit in each concern area.

## Regulatory Landscape

A reference map of major regulations, who they apply to, and where to find official sources. This is a starting point for research — always verify current requirements from official sources.

See [Regulatory Landscape](regulatory-landscape.md) for the full map.

## Audit Methodology

A structured 4-phase process for conducting compliance audits: scope → analyze → assess → report.

See [Audit Methodology](audit-methodology.md) for the full workflow and report template.

## Principles

1. **Jurisdiction determines requirements.** Never assume which regulations apply. Determine where users are, where data is stored, where the business operates, and what industry it's in.
2. **Research from official sources.** Regulatory body websites, official guidance, enforcement decisions. Not blog posts, not summaries, not LLM knowledge alone.
3. **Concern-first, regulation-second.** Audit each concern area (privacy, accessibility, etc.) and map applicable regulations to it, rather than going regulation by regulation.
4. **Cite everything.** Every requirement referenced in an audit must cite the specific regulation, article, and section.
5. **Distinguish requirements from recommendations.** Clearly label what is legally mandated vs. best practice vs. risk reduction recommendation.
6. **When in doubt, flag for legal review.** Compliance analysis is not legal advice. Flag ambiguous areas for qualified legal counsel.

## Avoid

- **Assuming regulations** — Always verify which regulations apply to specific jurisdictions and data types
- **One-time audits** — Regulations change; schedule periodic reviews
- **Checkbox compliance** — Implement the spirit, not just the letter of requirements
- **Ignoring enforcement actions** — Regulatory fines and decisions clarify interpretation
- **Siloed compliance** — Privacy, accessibility, and security overlap; coordinate efforts
- **Vendor assumption** — Third-party tools don't guarantee compliance; verify their claims
