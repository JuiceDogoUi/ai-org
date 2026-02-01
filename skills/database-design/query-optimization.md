# Query Optimization

## Use EXPLAIN
Always check the query plan before optimizing:
```sql
EXPLAIN ANALYZE SELECT * FROM users WHERE email = 'test@example.com';
```

## Common Issues
- **Full table scan**: Add an index on the filtered column
- **N+1 queries**: Use JOIN or batch loading
- **SELECT ***: Select only needed columns
- **Missing LIMIT**: Always paginate large result sets
- **Implicit type conversion**: Ensure types match in comparisons

## Patterns
```sql
-- Use EXISTS instead of IN for subqueries
SELECT * FROM users u WHERE EXISTS (
  SELECT 1 FROM orders o WHERE o.user_id = u.id
);

-- Use covering indexes
CREATE INDEX idx_users_status_email ON users(status, email);
SELECT email FROM users WHERE status = 'active'; -- index-only scan

-- Batch inserts
INSERT INTO logs (message, level) VALUES
  ('msg1', 'info'),
  ('msg2', 'warn'),
  ('msg3', 'error');
```
