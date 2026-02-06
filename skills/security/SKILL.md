---
name: security
description: Security best practices, OWASP Top 10, authentication patterns, and vulnerability prevention across web, mobile, API, and cloud.
user-invocable: false
---

# Security Conventions

## OWASP Top 10 (2021)

| ID | Category | Prevention |
|----|----------|------------|
| A01 | Broken Access Control | Check authz on every request, deny by default, RBAC. Includes SSRF—validate URLs, allowlist destinations |
| A02 | Cryptographic Failures | TLS everywhere, AES-256/RSA-2048+, secure key storage |
| A03 | Injection | Parameterized queries, input validation, output encoding |
| A04 | Insecure Design | Threat modeling, secure defaults, least privilege |
| A05 | Security Misconfiguration | Harden defaults, remove unused features, security headers |
| A06 | Vulnerable and Outdated Components | Dependency scanning, SBOM, update policy, SCA tools |
| A07 | Identification and Auth Failures | Strong passwords, MFA, rate limiting, secure sessions |
| A08 | Software and Data Integrity Failures | Signed updates, safe deserialization, CI/CD security |
| A09 | Security Logging and Monitoring Failures | Audit logs, no secrets in logs, alerting on anomalies |
| A10 | Server-Side Request Forgery (SSRF) | Validate URLs, allowlist destinations, block internal IPs |

## Input Validation

### Principles
- Validate on server, even if validated on client
- Allowlists over denylists
- Validate type, length, format, range
- Reject unexpected fields (strict schemas)

### Examples
```javascript
// Bad: Denylist approach
const sanitized = input.replace(/<script>/gi, '');

// Good: Allowlist with validation
const schema = z.object({
  email: z.string().email().max(255),
  age: z.number().int().min(0).max(150),
});
const validated = schema.parse(input);
```

## Authentication

### Password Handling
```javascript
// Preferred: Argon2id (OWASP recommendation)
const hash = await argon2.hash(password, { type: argon2.argon2id });
const valid = await argon2.verify(hash, password);

// Alternative: bcrypt (still acceptable)
const hash = await bcrypt.hash(password, 12); // cost factor 12+
const valid = await bcrypt.compare(password, hash);
```

### Token Patterns
- Short-lived JWTs (15min) with refresh tokens (7 days)
- Store refresh tokens securely (httpOnly cookie or secure storage)
- Include minimal claims in JWT (user ID, roles)
- Validate signature, expiration, issuer, audience

### Session Security
- Regenerate session ID on login
- Expire sessions after inactivity
- Single session or explicit multi-session management
- Invalidate sessions on password change

## Authorization

### Patterns
```javascript
// Check authorization on every request
async function getResource(userId, resourceId) {
  const resource = await db.resources.find(resourceId);
  if (resource.ownerId !== userId && !user.isAdmin) {
    throw new ForbiddenError('Access denied');
  }
  return resource;
}
```

### Principles
- Deny by default, explicitly grant access
- Check at resource level, not just route level
- Validate resource ownership for all operations
- Use RBAC or ABAC consistently

## Web Security

### Headers
```
Strict-Transport-Security: max-age=31536000; includeSubDomains
Content-Security-Policy: default-src 'self'; script-src 'self'
X-Content-Type-Options: nosniff
X-Frame-Options: DENY
Referrer-Policy: strict-origin-when-cross-origin
```

### Cookies
```javascript
res.cookie('session', token, {
  httpOnly: true,  // No JavaScript access
  secure: true,    // HTTPS only
  sameSite: 'strict', // CSRF protection
  maxAge: 3600000  // 1 hour
});
```

### XSS Prevention
```javascript
// Bad: Direct HTML insertion
element.innerHTML = userInput;

// Good: Text content or sanitization
element.textContent = userInput;
// Or with sanitization library
element.innerHTML = DOMPurify.sanitize(userInput);
```

## API Security

- Authenticate all endpoints (API keys, OAuth, JWT)
- Rate limiting per client/IP
- Validate all input, including headers
- Use HTTPS everywhere
- Return minimal error information

### GraphQL Specific
- Disable introspection in production
- Limit query depth (max 10-15 levels)
- Limit query complexity (cost analysis)
- Rate limit by client and query complexity

## Mobile Security

- Store secrets in Keychain (iOS) / Keystore (Android)
- Certificate pinning for API calls
- Detect root/jailbreak, obfuscate sensitive code
- No sensitive data in logs or backups
- Encrypt local database

## Cloud Security

- IAM least privilege, no wildcard permissions
- Private storage buckets by default
- Secrets in vault, not env vars or code
- Network segmentation, security groups
- Enable audit logging

## Avoid

- **Secrets in code or logs** — Use secrets manager; mask in logs
- **MD5/SHA1 for passwords** — Use Argon2id (preferred), bcrypt, or scrypt
- **JWT in localStorage** — Use httpOnly cookies; XSS can steal localStorage
- **Disabled HTTPS in development** — Use HTTPS everywhere, including local
- **Trust client-side validation** — Always validate on server
- **SQL concatenation** — Use parameterized queries exclusively
- **`eval()` or dynamic code execution** — Never with user input
- **Wildcard CORS** — Specify allowed origins explicitly
- **Hardcoded credentials** — Inject at runtime from secrets manager
- **Security through obscurity** — Assume attackers know your code
