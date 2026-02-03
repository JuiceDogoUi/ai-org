---
name: typescript
description: TypeScript language conventions, patterns, and configuration. Use when working with TypeScript code, configuring tsconfig, or applying TypeScript-specific patterns.
user-invocable: false
---

# TypeScript Conventions

## Type System

- Prefer `interface` over `type` for object shapes (interfaces are extendable)
- Use `type` for unions, intersections, and mapped types
- Avoid `any` -- use `unknown` for truly unknown types, then narrow
- Use discriminated unions for state modeling
- Prefer `readonly` for immutable data structures
- Use `as const` for literal type inference
- Leverage template literal types for string patterns

## Patterns

- Use strict mode (`"strict": true` in tsconfig)
- Prefer optional chaining (`?.`) and nullish coalescing (`??`)
- Use type guards and assertion functions for narrowing
- Prefer `satisfies` operator for type checking without widening
- Use branded types for type-safe identifiers (e.g., `UserId`, `OrderId`)

## Error Handling

- Define typed error classes extending `Error`
- Use result types (`{ ok: true, data: T } | { ok: false, error: E }`) for expected failures
- Reserve `throw` for unexpected/unrecoverable errors

## Async

- Prefer `async/await` over raw Promises
- Use `Promise.all` for independent concurrent operations
- Use `Promise.allSettled` when partial failure is acceptable
- Avoid floating promises -- always handle or await

## Avoid

- **`as` type assertions** — Use type guards or redesign types; assertions bypass safety
- **`any` type** — Use `unknown` and narrow with type guards
- **`!` non-null assertion** — Only use when you can prove value exists; prefer optional chaining
- **`@ts-ignore` / `@ts-expect-error`** — Fix the type error instead of suppressing it
- **`enum` for simple values** — Use union types (`type Status = 'pending' | 'done'`) for better tree-shaking
- **`Function` type** — Use specific signatures (`() => void`, `(x: string) => number`)
- **`object` type** — Use `Record<string, unknown>` or specific interfaces
- **Type assertions in tests** — Tests should validate real types, not bypass them
- **Overusing generics** — If `T` is always `string`, just use `string`
