---
name: kotlin
description: Kotlin language conventions, Jetpack Compose patterns, and Android development. Use when working with Kotlin code, Compose UI, or Android platform development.
user-invocable: false
---

# Kotlin Conventions

> **Documentation Freshness**: Kotlin and Jetpack Compose evolve across releases —
> new language features, Compose APIs, and coroutine patterns change frequently.
> Check kotlinlang.org and developer.android.com for current APIs.

## Language

- Use `val` over `var` — immutability by default
- Prefer data classes for DTOs and value objects
- Use sealed classes/interfaces for restricted hierarchies
- Use extension functions to add behavior without inheritance
- Prefer `when` expressions over complex if-else chains
- Use coroutines and `suspend` functions for async code
- Use `?.` safe calls and `?:` elvis operator for null handling

## Jetpack Compose

- Keep composables small and focused
- Extract composables when a function exceeds ~40 lines
- Use `remember` for expensive computations within composition
- Use `rememberSaveable` for state that survives configuration changes
- Hoist state to the appropriate level — stateless composables are easier to test
- Use `LaunchedEffect` for side effects tied to composition lifecycle
- Use `derivedStateOf` for computed state to avoid unnecessary recompositions

## State Management

- Use `StateFlow` for observable state in ViewModels
- Use `MutableState` / `mutableStateOf` for Compose-local state
- Collect flows with `collectAsStateWithLifecycle()` in composables
- Keep ViewModels focused — one per screen or feature

## Error Handling

- Use `Result<T>` or sealed classes for operation outcomes
- Use `runCatching` for wrapping throwing code
- Handle exceptions at the appropriate layer — don't catch everything

## Naming

- Types: `PascalCase`
- Functions/properties/variables: `camelCase`
- Constants: `SCREAMING_SNAKE_CASE`
- Composables: `PascalCase` (they act like components)
- Boolean properties: read as assertions (`isEnabled`, `hasContent`)

## Avoid

- **`!!` non-null assertions** — Causes NPE; use `?.`, `?:`, or `let`/`also` for null handling
- **`var` when `val` works** — Prefer immutability; `var` signals intentional mutation
- **`GlobalScope.launch`** — Leaks coroutines; use structured concurrency with proper scope
- **Blocking main thread** — Use `Dispatchers.IO` for blocking work, `Dispatchers.Default` for CPU
- **`remember {}` without keys** — Add keys when the remembered value depends on inputs
- **Side effects in composables** — Use `LaunchedEffect`, `DisposableEffect`, or event callbacks
- **Mutable state in ViewModel constructor** — Use `init {}` block or lazy initialization
- **`lateinit` for nullable types** — Use nullable type with `null` default instead
- **Exposing `MutableStateFlow`** — Expose as `StateFlow` to prevent external mutation
- **Platform types from Java interop** — Add explicit nullability annotations to Java code
