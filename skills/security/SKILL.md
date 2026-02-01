---
name: security
description: Security best practices, OWASP Top 10, authentication patterns, and vulnerability prevention. Use when reviewing or implementing security-sensitive code.
user-invocable: false
---

# Security Conventions

## OWASP Top 10 (Key Items)
1. **Injection**: Use parameterized queries, never concatenate user input into queries
2. **Broken Auth**: Use established auth libraries, enforce MFA where possible
3. **Sensitive Data Exposure**: Encrypt at rest and in transit, minimize data collection
4. **XSS**: Sanitize output, use framework auto-escaping, set CSP headers
5. **Broken Access Control**: Check permissions on every request, deny by default

## Input Validation
- Validate on the server, even if validated on the client
- Use allowlists over denylists
- Validate type, length, format, and range
- Reject unexpected fields (strict schemas)

## Authentication
- Hash passwords with bcrypt/argon2 (never MD5/SHA)
- Use short-lived JWTs with refresh tokens
- Implement rate limiting on auth endpoints
- Lock accounts after repeated failures

## Headers
- `Strict-Transport-Security: max-age=31536000; includeSubDomains`
- `Content-Security-Policy: default-src 'self'`
- `X-Content-Type-Options: nosniff`
- `X-Frame-Options: DENY`

For auth patterns, see [auth-patterns.md](auth-patterns.md).
For vulnerability checklist, see [vulnerability-checklist.md](vulnerability-checklist.md).
