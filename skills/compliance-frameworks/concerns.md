# Compliance Concern Areas

What to audit in each concern area. These are jurisdiction-agnostic — the specific regulatory requirements come from web research based on the project's applicable jurisdictions.

## Privacy

Privacy concerns apply whenever the project collects, processes, or stores personal data.

### What to check:

**Data inventory**
- What personal data is collected (name, email, IP, device ID, location, behavioral data, etc.)?
- Where is it stored (database, cookies, localStorage, third-party services)?
- How long is it retained? Is there an automated deletion/archival process?
- Who has access (internal roles, third-party processors)?
- Is data transferred across borders? To which countries?

**Consent and lawful basis**
- Is there a mechanism for collecting user consent before processing personal data?
- Can users withdraw consent? Is it as easy to withdraw as to give?
- Is the lawful basis for each type of processing documented?
- Are consent records stored (who consented, when, to what)?

**Data subject rights**
- Can users access/export their data?
- Can users request correction of inaccurate data?
- Can users request deletion of their data? Does deletion cascade to backups, logs, third parties?
- Can users request data portability (machine-readable export)?
- Is there a process for responding to data subject requests within regulatory timeframes?

**Third-party data sharing**
- What third-party services receive personal data (analytics, advertising, payment processors, CDNs)?
- Are data processing agreements in place?
- Do third parties meet the same regulatory requirements?

**Breach response**
- Is there an incident response plan for data breaches?
- Does the plan include notification timelines (varies by regulation)?
- Are there monitoring systems to detect unauthorized access?

## Accessibility

Accessibility concerns apply to all user-facing interfaces — web, mobile, desktop.

For audit checklists organized by keyboard, images, forms, contrast, structure, and dynamic content, use `accessibility/checklist.md`. For WCAG conformance levels, commonly failed criteria, and testing methodology, see `wcag.md`.

## Data Security

Data security concerns apply whenever the project handles sensitive data or operates infrastructure.

### What to check:

**Encryption**
- Is data encrypted in transit (TLS for all connections)?
- Is sensitive data encrypted at rest (database, file storage)?
- Are encryption keys managed securely (not hardcoded, rotated)?

**Access control**
- Is authentication implemented for all protected resources?
- Is authorization role-based with principle of least privilege?
- Are API endpoints protected against unauthorized access?
- Are admin interfaces separately secured?

**Logging and audit trails**
- Are security-relevant events logged (login attempts, data access, permission changes)?
- Are logs tamper-resistant and retained for required periods?
- Are logs free of sensitive data (no passwords, tokens, PII in logs)?

**Input validation**
- Are all user inputs validated and sanitized?
- Is the application protected against injection attacks (SQL, XSS, command)?
- Are file uploads validated for type, size, and content?

**Incident response**
- Is there a documented incident response plan?
- Are there monitoring and alerting systems for security events?
- Is there a process for security patch management?

## Licensing

Licensing concerns apply to all projects using third-party code or libraries.

### What to check:

**Dependency audit**
- What are all direct and transitive dependencies?
- What license does each dependency use?
- Are all licenses compatible with the project's license?

**License compatibility**
- Permissive licenses (MIT, BSD, Apache 2.0) are generally compatible with everything
- Copyleft licenses (GPL, AGPL) require derivative works to use the same license
- AGPL extends copyleft to network use (SaaS)
- Some licenses have specific attribution or notice requirements

**Attribution**
- Are required attribution notices included?
- Are license texts included for dependencies that require it?
- Is a NOTICE or THIRD-PARTY-LICENSES file maintained?

## Cookie and Tracking Consent

Cookie/tracking concerns apply to web applications that use cookies, tracking pixels, or similar technologies.

### What to check:

- Is a cookie consent mechanism implemented?
- Are non-essential cookies blocked until consent is given?
- Can users selectively consent to cookie categories (necessary, functional, analytics, advertising)?
- Can users withdraw cookie consent?
- Is a cookie policy/notice available explaining what each cookie does?
- Are third-party tracking scripts (analytics, advertising) gated behind consent?

## Industry-Specific

Some industries have additional regulatory requirements (healthcare, finance, education, children's services, government). See `regulatory-landscape.md` for the full regulation map with jurisdictions and official sources.
