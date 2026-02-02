# SOX Quick Reference

The Sarbanes-Oxley Act (SOX) applies to publicly traded companies in the US and their IT systems that affect financial reporting. This is a quick reference for the IT controls most relevant to software projects.

**Official sources**: sec.gov (SEC rules), pcaobus.org (PCAOB auditing standards), isaca.org (COBIT framework for IT governance)

## When SOX Applies to Software

SOX applies when the software:
- Processes, stores, or reports financial data used in public company reporting
- Controls access to financial systems
- Generates data that feeds into financial statements
- Is part of the IT infrastructure supporting financial reporting

If the project doesn't affect financial reporting for a public company, SOX likely doesn't apply.

## Key IT Controls (Section 404)

| Control Area | Requirement | What to check |
|-------------|------------|--------------|
| Access control | Role-based access, least privilege, regular reviews | Are admin roles separated? Are access reviews documented? |
| Change management | All changes tracked, reviewed, approved before deployment | Is there a PR/review process? Are deployments auditable? |
| Segregation of duties | No single person controls an entire financial process | Can the same person create and approve transactions? |
| Audit trail | Complete logging of who did what and when | Are financial data modifications logged with user, timestamp, before/after? |
| Data integrity | Validation, checksums, reconciliation | Are financial calculations verified? Is data validated at entry? |
| Backup and recovery | Tested backup and disaster recovery | Are backups verified? Is recovery tested periodically? |
| Encryption | Financial data protected at rest and in transit | TLS for all connections? Encrypted database columns for financial data? |

## Common Software Audit Points

- Version control with complete history (who changed what, when, and why)
- Code review process documented and enforced
- Deployment approvals separated from development
- Database migration scripts tracked in version control
- No direct production database access without audit logging
- Automated tests for financial calculations
- Environment separation (dev/staging/production)

## Relationship to Other Frameworks

SOX IT controls overlap significantly with:
- **ISO 27001** — information security management (broader scope)
- **COBIT** — IT governance framework (often used to structure SOX IT compliance)
- **NIST CSF** — cybersecurity framework (complementary)

Research the specific SOX compliance requirements from your company's auditor, as interpretation and emphasis vary.
