---
name: sql
description: SQL query patterns, optimization, and database best practices. Use when writing queries, designing schemas, or optimizing database performance.
user-invocable: false
---

# SQL Conventions

## Query Writing

- Use uppercase for SQL keywords: `SELECT`, `FROM`, `WHERE`, `JOIN`
- Use lowercase for table and column names with underscores: `user_accounts`
- Always qualify column names with table aliases in JOINs
- Use meaningful table aliases: `u` for users, `o` for orders
- Prefer explicit `INNER JOIN` over implicit joins in WHERE
- Use `LEFT JOIN` only when you need unmatched rows

## SELECT Patterns

- Never use `SELECT *` in production code — list columns explicitly
- Use column aliases for computed values: `COUNT(*) AS total_count`
- Order columns logically: identifiers first, then attributes, then timestamps
- Use `COALESCE` for null handling: `COALESCE(name, 'Unknown')`
- Use `CASE WHEN` for conditional logic in SELECT

## WHERE Clauses

- Put most selective conditions first (helps query planner)
- Use `IN` for small lists, `EXISTS` for subqueries with large result sets
- Use parameterized queries — NEVER concatenate user input
- Use `BETWEEN` for date ranges (inclusive)
- Avoid functions on indexed columns: `WHERE date_col >= '2024-01-01'` not `WHERE YEAR(date_col) = 2024`

## JOINs

- Always specify join type explicitly: `INNER JOIN`, `LEFT JOIN`
- Join on indexed columns when possible
- Order joins from smallest to largest result set
- Use `LEFT JOIN` + `IS NULL` pattern for finding missing records
- Avoid `CROSS JOIN` unless you truly need a Cartesian product

## Indexing

- Index columns used in WHERE, JOIN, and ORDER BY
- Create composite indexes in order of selectivity
- Consider covering indexes for frequently queried column sets
- Index foreign key columns
- Avoid over-indexing — each index slows writes

## Aggregations

- Use `GROUP BY` with all non-aggregated columns in SELECT
- Use `HAVING` for filtering aggregated results (not WHERE)
- Consider `DISTINCT ON` (PostgreSQL) for first-per-group queries
- Use window functions for running totals, rankings, partitioned aggregates

## Transactions

- Use explicit `BEGIN`/`COMMIT` for multi-statement operations
- Keep transactions short to avoid locking issues
- Use appropriate isolation level for your use case
- Handle deadlocks with retry logic in application code

## Performance

- Use `EXPLAIN ANALYZE` to understand query plans
- Avoid N+1 queries — use JOINs or batch fetching
- Use `LIMIT` with `OFFSET` carefully — prefer keyset pagination
- Denormalize read-heavy data strategically
- Use connection pooling for application access

## Avoid

- **SELECT *** — Always list columns explicitly
- **String concatenation for queries** — Use parameterized queries
- **Functions on indexed columns in WHERE** — Prevents index usage
- **Large OFFSET values** — Use keyset/cursor pagination instead
- **DISTINCT to hide JOIN issues** — Fix the join logic
- **NULL in equality checks** — Use `IS NULL` / `IS NOT NULL`
- **Subqueries where JOINs work** — JOINs are usually more efficient
- **ORDER BY without LIMIT on large tables** — Full table sort is expensive
- **Implicit type conversions** — Cast explicitly
- **Ignoring query plans** — Always EXPLAIN complex queries

## Related Skills

- **database-design** — Schema design, migrations, index types, and data modeling
