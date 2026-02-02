# GDPR Quick Reference

The General Data Protection Regulation (EU 2016/679) governs processing of personal data of EU/EEA residents. This is a quick reference for common audit points — always research current requirements and guidance from official sources.

**Official sources**: gdpr.eu (full text), ec.europa.eu (European Commission guidance), edpb.europa.eu (European Data Protection Board guidelines)

## Key Principles (Article 5)

| Principle | Meaning | What to check |
|-----------|---------|--------------|
| Lawfulness | Valid legal basis for every processing activity | Is lawful basis documented for each data type? |
| Purpose limitation | Data collected for specified, explicit purposes only | Is each data collection tied to a stated purpose? |
| Data minimization | Only data that is necessary is collected | Is there data collected that isn't needed? |
| Accuracy | Personal data must be kept accurate and up to date | Can users correct their data? |
| Storage limitation | Data not kept longer than necessary | Is there a retention policy with automated enforcement? |
| Integrity and confidentiality | Appropriate security measures | Encryption, access control, breach detection? |
| Accountability | Controller must demonstrate compliance | Are processing records maintained? |

## Data Subject Rights (Articles 12-22)

| Right | Article | Response Time | What to implement |
|-------|---------|--------------|------------------|
| Access | 15 | 1 month | Data export functionality |
| Rectification | 16 | 1 month | Profile editing |
| Erasure ("right to be forgotten") | 17 | 1 month | Account/data deletion (cascade to backups, third parties) |
| Restrict processing | 18 | 1 month | Ability to pause processing |
| Data portability | 20 | 1 month | Machine-readable export (JSON/CSV) |
| Object | 21 | Without delay | Opt-out of processing (especially direct marketing) |
| Withdraw consent | 7(3) | — | Must be as easy as giving consent |

## High-Risk Areas to Research

- **Cross-border transfers** (Chapter V) — transfer mechanisms (SCCs, adequacy decisions, BCRs) have evolved significantly since 2018. Research current EDPB guidance.
- **Children's data** (Article 8) — age of consent varies by member state (13-16). Research the specific countries your users are in.
- **Data Protection Officer** (Articles 37-39) — required for certain types of processing. Research whether your processing activities trigger this requirement.
- **Data Protection Impact Assessment** (Article 35) — required for high-risk processing. Research current guidance on what constitutes "high risk."
- **Records of processing** (Article 30) — required for organizations with 250+ employees or those processing special category data.
- **Breach notification** (Articles 33-34) — 72-hour notification to supervisory authority. Research the specific procedure for your lead supervisory authority.

## Common Technical Gaps

These are frequently found in codebase audits:
- Analytics/tracking scripts firing before consent is collected
- No automated data deletion when retention period expires
- Personal data in application logs (IPs, emails, names)
- Third-party SDKs sharing data without documented processing agreements
- No mechanism for handling data subject access requests
- Consent records not stored (no proof of when/what user consented to)
- Data deletion that doesn't cascade to backups and third-party processors
