# Authentication Patterns

## JWT Flow
1. User sends credentials to `/auth/login`
2. Server validates, returns `{ accessToken, refreshToken }`
3. Client sends `Authorization: Bearer <accessToken>` on each request
4. When access token expires, client calls `/auth/refresh` with refresh token
5. Server issues new access + refresh token pair

## Token Guidelines
- Access token: 15-minute expiry, stateless
- Refresh token: 7-day expiry, stored in DB (revocable)
- Never store tokens in localStorage (XSS risk)
- Use httpOnly, secure, sameSite cookies for web

## Password Rules
- Minimum 8 characters, check against breached password lists
- Hash with bcrypt (cost factor 12+) or argon2id
- Never log or expose passwords, even in error messages

## Session Management
- Regenerate session ID after authentication
- Implement absolute timeout (e.g., 24 hours)
- Implement idle timeout (e.g., 30 minutes)
- Provide logout that invalidates server-side session
