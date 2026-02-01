# API Documentation Template

## Endpoint Documentation

### [METHOD] /path

Brief description of what this endpoint does.

**Authentication**: Required / Optional / None

**Request**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| id        | string | Yes    | The user's unique identifier |

**Request Body**
```json
{
  "name": "string",
  "email": "string"
}
```

**Response** `200 OK`
```json
{
  "id": "usr_123",
  "name": "Alice",
  "email": "alice@example.com",
  "createdAt": "2024-01-01T00:00:00Z"
}
```

**Error Responses**

| Status | Code | Description |
|--------|------|-------------|
| 400 | VALIDATION_ERROR | Invalid request body |
| 404 | NOT_FOUND | User not found |

**Example**
```bash
curl -X GET https://api.example.com/users/usr_123 \
  -H "Authorization: Bearer <token>"
```
