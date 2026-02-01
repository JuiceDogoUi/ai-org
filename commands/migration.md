---
name: migration
description: Create a database migration
argument-hint: "[migration description]"
context: fork
agent: eng-database
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
