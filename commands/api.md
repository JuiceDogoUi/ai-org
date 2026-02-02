---
name: api
description: Design or implement an API endpoint
argument-hint: "[endpoint description]"
context: fork
agent: eng-api
---

Design and implement an API endpoint: $ARGUMENTS

## Process

1. Define the endpoint contract (method, path, request/response shapes)
2. Implement the handler following project conventions
3. Add input validation and error handling
4. Write integration test
5. Document the endpoint

## Output

- Endpoint implementation with validation and error handling
- Request/response type definitions
- Test covering happy path and error cases
- API documentation (inline or OpenAPI)

> Related: `/component` to scaffold the frontend, `/db-migrate` for schema changes, `/docs` to document the API.
