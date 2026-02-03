---
name: docs
description: Generate or update documentation
argument-hint: "[target: file, module, API, or 'project']"
context: fork
agent: writer-lead
---

Generate documentation for: $ARGUMENTS

## Process

1. Analyze the target code or system
2. Identify what needs documenting (API, setup, architecture, usage)
3. Write clear documentation following technical writing best practices
4. Include code examples where appropriate
5. Follow the project's existing documentation conventions

## Standards

- Write for the reader, not the author
- Lead with the most important information
- Use concrete examples over abstract descriptions
- Keep paragraphs short and scannable
- If updating existing docs, preserve the existing structure

## Output

- If target is a file/module: create or update a doc file adjacent to the source (e.g., `README.md` in the module directory)
- If target is "project": create or update the project root `README.md`
- If target is an API: create or update docs in the project's API documentation location
- Preserve existing documentation structure — update in place, don't create duplicates

> Related: `/component` for component documentation, `/prd` for product requirements.
