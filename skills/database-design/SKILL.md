---
name: database-design
description: Database schema design, migrations, query optimization, and data modeling. Use when working with databases, writing queries, or designing data models.
user-invocable: false
---

# Database Design

## Schema Design

### Core Principles
- Normalize to 3NF by default, denormalize only with measured need
- Use UUIDs for public-facing IDs, auto-increment for internal
- Add `created_at` and `updated_at` timestamps to all tables
- Use soft deletes (`deleted_at`) when audit trail is needed
- Define foreign keys and constraints explicitly

### Data Types
- Use appropriate types: `TIMESTAMP` for times, `DECIMAL` for money, `UUID` for IDs
- Prefer `TEXT` over `VARCHAR` unless length constraint is meaningful
- Use `BOOLEAN` not integers for true/false
- Store JSON only when schema is truly dynamic

### Constraints
```sql
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email TEXT NOT NULL UNIQUE,
  status TEXT NOT NULL CHECK (status IN ('active', 'suspended', 'deleted')),
  organization_id UUID NOT NULL REFERENCES organizations(id),
  created_at TIMESTAMP NOT NULL DEFAULT now(),
  updated_at TIMESTAMP NOT NULL DEFAULT now()
);
```

## Indexing

### When to Index
- All foreign keys
- Columns used in WHERE clauses
- Columns used in ORDER BY
- Columns used in JOIN conditions

### Composite Indexes
```sql
-- For queries like: WHERE user_id = ? AND status = ? ORDER BY created_at
CREATE INDEX idx_orders_user_status_created
ON orders(user_id, status, created_at DESC);
```

Leftmost prefix rule: index on (A, B, C) supports queries on A, (A, B), or (A, B, C), but not B alone.

### Index Types
- **B-tree** (default): Range queries, equality, sorting
- **Hash**: Equality only, faster for exact matches
- **GIN**: Full-text search, JSONB, arrays
- **Partial**: Index subset of rows: `WHERE deleted_at IS NULL`

## Query Optimization

### Analyze Queries
```sql
EXPLAIN ANALYZE SELECT * FROM orders WHERE user_id = 'abc' AND status = 'pending';
```

Look for:
- Seq Scan on large tables (missing index)
- High row estimates vs actual (stale statistics)
- Nested loops on large sets (consider hash join)

### N+1 Prevention
```sql
-- Bad: N+1 queries
SELECT * FROM users;
-- Then for each user: SELECT * FROM orders WHERE user_id = ?

-- Good: Single query with JOIN
SELECT u.*, o.* FROM users u
LEFT JOIN orders o ON o.user_id = u.id;

-- Or: IN clause
SELECT * FROM orders WHERE user_id IN (?, ?, ?);
```

### Pagination
```sql
-- Offset pagination (simple but slow on large offsets)
SELECT * FROM orders ORDER BY created_at DESC LIMIT 20 OFFSET 100;

-- Cursor pagination (consistent, performant)
SELECT * FROM orders
WHERE created_at < '2024-01-15T10:00:00Z'
ORDER BY created_at DESC
LIMIT 20;
```

## Migrations

### Principles
- Migrations are append-only — never edit deployed migrations
- Include both up and down migrations
- Make migrations idempotent when possible
- Test migrations on production-sized data

### Safe Migrations
```sql
-- Adding column (safe)
ALTER TABLE users ADD COLUMN phone TEXT;

-- Adding NOT NULL column (do in steps)
-- Step 1: Add nullable
ALTER TABLE users ADD COLUMN phone TEXT;
-- Step 2: Backfill data
UPDATE users SET phone = '' WHERE phone IS NULL;
-- Step 3: Add constraint
ALTER TABLE users ALTER COLUMN phone SET NOT NULL;
```

### Dangerous Operations
- Dropping columns/tables (data loss)
- Adding NOT NULL without default (locks table)
- Adding unique constraint on existing data
- Changing column type

## Transactions

### ACID Properties
- **Atomicity**: All or nothing
- **Consistency**: Valid state to valid state
- **Isolation**: Concurrent transactions don't interfere
- **Durability**: Committed data survives crashes

### Isolation Levels
- **Read Uncommitted**: Sees dirty reads (rarely used)
- **Read Committed**: Sees only committed data (PostgreSQL default)
- **Repeatable Read**: Consistent snapshot within transaction
- **Serializable**: Full isolation (performance cost)

### Patterns
```sql
BEGIN;
  UPDATE accounts SET balance = balance - 100 WHERE id = 1;
  UPDATE accounts SET balance = balance + 100 WHERE id = 2;
COMMIT;
```

## Naming Conventions

- Tables: plural, snake_case (`user_profiles`)
- Columns: snake_case (`first_name`)
- Foreign keys: `{referenced_table_singular}_id` (`user_id`)
- Indexes: `idx_{table}_{columns}` (`idx_users_email`)
- Constraints: `{table}_{column}_{type}` (`users_email_unique`)

## NoSQL Considerations

### When to Use
- Truly schema-less data
- High write throughput needs
- Horizontal scaling requirements
- Document or graph-shaped data

### Document Databases (MongoDB)
- Embed related data that's always accessed together
- Reference data that's accessed independently
- Denormalize for read performance, accept write complexity

### Key-Value (Redis)
- Caching, sessions, rate limiting
- Set TTL on cached data
- Use appropriate data structures (sets, sorted sets, hashes)

## Avoid

- **N+1 queries** — Use JOINs, IN clauses, or eager loading
- **SELECT \*** — Specify columns; reduces network, enables covering indexes
- **Missing indexes on foreign keys** — Causes slow JOINs and cascading deletes
- **Indexing every column** — Each index slows writes; index what queries need
- **Storing computed values** — Derive at query time unless performance demands it
- **Large transactions** — Hold locks briefly; batch large updates
- **Ignoring EXPLAIN** — Always analyze slow queries
- **Nullable foreign keys without reason** — Usually indicates design issue
- **VARCHAR(255) everywhere** — Use appropriate lengths or TEXT
- **Trusting ORM-generated queries** — Review SQL for performance-critical paths

## Related Skills

- **sql** — SQL query patterns, WHERE clauses, JOINs, aggregations, and query optimization
