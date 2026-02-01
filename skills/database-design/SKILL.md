---
name: database-design
description: Database schema design, migrations, and query optimization. Use when working with databases, writing queries, or designing data models.
user-invocable: false
---

# Database Design

## Schema Design
- Normalize to 3NF by default, denormalize only with measured need
- Use UUIDs for public-facing IDs, auto-increment for internal
- Add `created_at` and `updated_at` timestamps to all tables
- Use soft deletes (`deleted_at`) when audit trail is needed
- Define foreign keys and constraints explicitly

## Indexing
- Index all foreign keys
- Index columns used in WHERE, ORDER BY, and JOIN
- Use composite indexes matching query patterns (leftmost prefix rule)
- Avoid over-indexing -- each index slows writes

## Naming
- Tables: plural, snake_case (`user_profiles`)
- Columns: snake_case (`first_name`)
- Foreign keys: `{referenced_table_singular}_id` (`user_id`)
- Indexes: `idx_{table}_{columns}` (`idx_users_email`)

For migration patterns, see [migrations.md](migrations.md).
For query optimization, see [query-optimization.md](query-optimization.md).
