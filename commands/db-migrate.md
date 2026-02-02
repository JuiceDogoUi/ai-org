---
name: db-migrate
description: Create a database migration
argument-hint: "[migration description]"
context: fork
agent: eng-backend
---

Create a database migration for: $ARGUMENTS

## Process

1. Analyze current schema to understand existing structure
2. Design the migration (up and down)
3. Consider data preservation and backwards compatibility
4. Generate migration file following project conventions
5. Document breaking changes if any

## Standards

- Always include a rollback (down) migration
- Preserve existing data where possible
- Use transactions for multi-step migrations
- Test with representative data volumes in mind

## Output

- Migration file following the project's naming convention (e.g., `{timestamp}_{description}.sql`, or ORM-specific format)
- Up migration (apply changes)
- Down migration (rollback changes)
- Documentation of breaking changes if any

> Related: `/api` if the migration supports a new endpoint, `/docs` to update schema documentation.
