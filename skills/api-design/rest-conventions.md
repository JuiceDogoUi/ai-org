# REST API Conventions

## Versioning
- URL prefix: `/api/v1/users` (recommended for simplicity)
- Header: `Accept: application/vnd.api.v1+json`
- Only version when breaking changes are needed

## Filtering & Sorting
```bash
GET /users?status=active&role=admin          # Filtering
GET /users?sort=created_at&order=desc        # Sorting
GET /users?fields=id,name,email              # Sparse fields
```

## Pagination Response
```json
{
  "data": [...],
  "pagination": {
    "total": 100,
    "page": 1,
    "size": 20,
    "hasNext": true
  }
}
```

## Bulk Operations
```text
POST /users/bulk    { "items": [...] }
DELETE /users/bulk  { "ids": [...] }
```

## Rate Limiting Headers
```text
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 95
X-RateLimit-Reset: 1609459200
```
