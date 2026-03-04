---
name: api-design
description: REST and GraphQL API design principles, conventions, and error handling patterns. Use when designing or implementing APIs.
user-invocable: false
---

# API Design Conventions

> **Documentation Freshness**: REST and GraphQL standards evolve — check the
> OpenAPI Specification (swagger.io/specification) and GraphQL spec (spec.graphql.org)
> for current conventions. Verify HTTP semantics against RFC 9110.

## File Guide
- **error-handling.md** — Standard error response structure and error codes
- **rest-conventions.md** — Versioning, filtering, pagination, bulk operations, rate limiting

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

## Request/Response Examples

### Successful Response
```json
{
  "data": {
    "id": "usr_123",
    "email": "user@example.com",
    "createdAt": "2024-01-15T10:30:00Z"
  }
}
```

### Collection Response
```json
{
  "data": [
    { "id": "usr_123", "email": "user@example.com" }
  ],
  "pagination": {
    "cursor": "eyJpZCI6MTIzfQ",
    "hasMore": true
  }
}
```

## Error Handling

See **error-handling.md** for standard error response structure, error codes, and rules.

## Versioning

See **rest-conventions.md** for versioning strategies and conventions.

## GraphQL

### Schema Design
- Use clear, descriptive type names
- Prefer nullable fields (non-null only when guaranteed)
- Use connections for paginated lists
- Define input types for mutations

### Query Patterns
```graphql
type Query {
  user(id: ID!): User
  users(first: Int, after: String): UserConnection!
}

type Mutation {
  createUser(input: CreateUserInput!): CreateUserPayload!
}
```

### Security

For GraphQL security (introspection, query depth/complexity, rate limiting), see the `security` skill.

## API Documentation

- OpenAPI/Swagger spec for REST
- GraphQL SDL with descriptions
- Include request/response examples
- Document authentication requirements
- List all possible error codes

## Avoid

- **Verbs in URLs** — Use HTTP methods instead: `POST /users` not `POST /createUser`
- **Exposing internal IDs** — Use opaque IDs (`usr_abc123`) not auto-increment (`123`)
- **Breaking changes without versioning** — Always version when changing contracts
- **Inconsistent naming** — Pick camelCase or snake_case and use everywhere
- **Over-fetching by default** — Support field selection or use GraphQL
- **Nested resources beyond 3 levels** — Flatten with query params instead
- **200 OK for errors** — Use appropriate 4xx/5xx status codes
- **Generic error messages** — "Something went wrong" doesn't help clients
- **Missing rate limiting** — Every public API needs protection
- **Undocumented endpoints** — If it's not documented, it doesn't exist
