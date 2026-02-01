# API Error Handling

## Standard Error Response
```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "The request contains invalid fields",
    "details": [
      {
        "field": "email",
        "message": "Must be a valid email address"
      }
    ]
  }
}
```

## Error Codes
Use machine-readable codes alongside HTTP status:
- `VALIDATION_ERROR` (400)
- `AUTHENTICATION_REQUIRED` (401)
- `INSUFFICIENT_PERMISSIONS` (403)
- `RESOURCE_NOT_FOUND` (404)
- `DUPLICATE_RESOURCE` (409)
- `RATE_LIMITED` (429)
- `INTERNAL_ERROR` (500)

## Rules
- Never expose stack traces in production
- Include a request ID for tracing: `"requestId": "req_abc123"`
- Log full error server-side, return safe message client-side
- Use consistent error shape across all endpoints
