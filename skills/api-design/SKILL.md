---
name: api-design
description: REST and GraphQL API design principles, conventions, and error handling patterns. Use when designing or implementing APIs.
user-invocable: false
---

# API Design Conventions

## REST

### URL Structure
- Use nouns, not verbs: `/users`, not `/getUsers`
- Use plural nouns: `/users`, not `/user`
- Nest for relationships: `/users/{id}/orders`
- Use kebab-case for multi-word paths: `/user-profiles`
- Keep URLs max 3 levels deep

### HTTP Methods
- `GET` - Read (idempotent, cacheable)
- `POST` - Create
- `PUT` - Full replace
- `PATCH` - Partial update
- `DELETE` - Remove

### Status Codes
- `200` OK (with body)
- `201` Created (with Location header)
- `204` No Content (successful, no body)
- `400` Bad Request (validation error)
- `401` Unauthorized (not authenticated)
- `403` Forbidden (not authorized)
- `404` Not Found
- `409` Conflict (duplicate, state conflict)
- `422` Unprocessable Entity (semantic error)
- `429` Too Many Requests
- `500` Internal Server Error

### Pagination
- Use cursor-based for real-time data: `?cursor=abc&limit=20`
- Use offset-based for static data: `?page=1&size=20`
- Return pagination metadata in response body

For REST conventions detail, see [rest-conventions.md](rest-conventions.md).
For error handling patterns, see [error-handling.md](error-handling.md).
