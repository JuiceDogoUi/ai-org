# Migration Patterns

## Rules
- Always include up AND down migrations
- One logical change per migration
- Never modify a deployed migration -- create a new one
- Test migrations against production-like data volumes
- Use transactions for multi-step changes

## Adding a Column
```sql
-- Up
ALTER TABLE users ADD COLUMN phone VARCHAR(20);

-- Down
ALTER TABLE users DROP COLUMN phone;
```

## Adding an Index (Non-Blocking)
```sql
-- Up (PostgreSQL)
CREATE INDEX CONCURRENTLY idx_users_email ON users(email);

-- Down
DROP INDEX idx_users_email;
```

## Data Migration
```sql
-- Up
ALTER TABLE orders ADD COLUMN status VARCHAR(20) DEFAULT 'pending';
UPDATE orders SET status = 'completed' WHERE completed_at IS NOT NULL;
ALTER TABLE orders ALTER COLUMN status SET NOT NULL;

-- Down
ALTER TABLE orders DROP COLUMN status;
```
