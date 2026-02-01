---
name: docs
description: Generate or update documentation
argument-hint: "[target: file, module, API, or 'project']"
context: fork
agent: writer-technical
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
