---
name: javascript
description: Modern JavaScript patterns, ES modules, and async patterns. Use when working with vanilla JS or JS-specific concerns.
user-invocable: false
---

# JavaScript Conventions

## Modern Syntax
- Use `const` by default, `let` when reassignment is needed, never `var`
- Use arrow functions for callbacks and short functions
- Use template literals for string interpolation
- Destructure objects and arrays at point of use
- Use optional chaining (`?.`) and nullish coalescing (`??`)
- Use ES modules (`import`/`export`) over CommonJS (`require`)

## Async Patterns
- Prefer `async/await` over `.then()` chains
- Use `Promise.all()` for independent concurrent operations
- Use `AbortController` for cancellable operations
- Handle errors with try/catch at the appropriate level

## Array Methods
- `map` for transformations, `filter` for selection, `reduce` for aggregation
- `find` for single item lookup, `some`/`every` for boolean checks
- Prefer these over `for` loops for data transformation
- Use `for...of` when you need `break`/`continue` or side effects

## DOM (when applicable)
- Use `querySelector`/`querySelectorAll` over older APIs
- Use event delegation for repeated elements
- Prefer `textContent` over `innerHTML` for text (XSS prevention)
- Use `requestAnimationFrame` for visual updates

For async patterns, see [async-patterns.md](async-patterns.md).
For general patterns, see [patterns.md](patterns.md).
