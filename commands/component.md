---
name: component
description: Scaffold a UI component following project conventions
argument-hint: "[component name and description]"
context: fork
agent: eng-frontend
---

Create a new component: $ARGUMENTS

## Process

1. Detect the project's framework and conventions
2. Examine existing components for patterns (file structure, naming, imports)
3. Scaffold component files (template, styles, logic, tests)
4. Follow existing patterns found in the codebase
5. Include accessibility attributes
6. Add basic unit test

## Standards

- Match the project's component structure exactly
- Use the same styling approach (CSS modules, SCSS, Tailwind, etc.)
- Include all standard files the project uses per component
- Follow the naming convention found in existing components
