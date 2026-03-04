---
name: swift
description: Swift language conventions, SwiftUI patterns, and iOS development. Use when working with Swift code, SwiftUI views, or Apple platform development.
user-invocable: false
---

# Swift Conventions

> **Documentation Freshness**: Swift and SwiftUI evolve with each Xcode release —
> the Observation framework (iOS 17+), Swift concurrency, and SwiftUI APIs change
> across versions. Check developer.apple.com for current APIs.

## File Guide
- **patterns.md** — Swift patterns: networking, protocol-oriented design, dependency injection, enums
- **swiftui.md** — SwiftUI patterns: Observable state, view composition, navigation

## Language

- Use value types (structs, enums) by default; classes only for reference semantics or identity
- Prefer `let` over `var` -- immutability by default
- Use Swift's type inference -- avoid redundant type annotations
- Use trailing closure syntax for the last closure parameter
- Prefer `guard` for early returns over nested `if let`
- Use `async/await` over completion handlers for modern async code

## SwiftUI

- Keep views small and composable
- Extract subviews when a view body exceeds ~30 lines
- Use `@State` for local view state
- Use `@Binding` for two-way child-to-parent communication
- Use `@Observable` (Observation framework) for shared state (iOS 17+)
- Use `@Environment` for dependency injection
- Prefer `task {}` modifier for async work over `onAppear`

## Error Handling

- Define domain errors as enums conforming to `Error`
- Use `throws` for synchronous errors, `async throws` for async
- Handle errors at the appropriate level -- don't catch everything at the call site
- Use `Result` type when storing or passing errors as values

## Naming

- Types: `PascalCase`
- Functions/properties/variables: `camelCase`
- Protocols: noun or adjective (`Identifiable`, `DataStore`)
- Boolean properties: read as assertions (`isEnabled`, `hasContent`)

## Avoid

- **Force unwrap (`!`)** — Use `guard let`, `if let`, or `??` with defaults; force unwrap crashes
- **`class` when `struct` suffices** — Prefer value types; classes add reference semantics complexity
- **Heavy work in `onAppear`** — Use `.task {}` modifier for async work with automatic cancellation
- **Completion handlers in new code** — Use `async/await` for cleaner async patterns
- **Massive view bodies** — Extract subviews when exceeding ~30 lines
- **`@State` for shared state** — Use `@Observable` or `@EnvironmentObject` for app-wide state
- **`AnyView` for type erasure** — Performance cost; use `@ViewBuilder` or generics instead
- **Ignoring `@MainActor`** — UI updates must be on main thread; use proper actor isolation
- **String-based `UserDefaults` keys** — Define constants or use property wrappers
- **`try?` that silently swallows errors** — Log or handle the error appropriately
