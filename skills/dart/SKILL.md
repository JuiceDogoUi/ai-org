---
name: dart
description: Dart language conventions, Flutter patterns, and cross-platform mobile development. Use when working with Dart code, Flutter widgets, or cross-platform apps.
user-invocable: false
---

# Dart Conventions

> **Documentation Freshness**: Dart and Flutter evolve rapidly — Dart 3 introduced
> patterns, records, and class modifiers. Flutter widget APIs and state management
> libraries change across releases. Check dart.dev and flutter.dev for current APIs.

## Language

- Use `final` over `var` for variables that won't be reassigned
- Use `const` for compile-time constants and immutable widgets
- Prefer named parameters for functions with multiple parameters
- Use cascade notation (`..`) for chaining operations on the same object
- Use null safety — prefer non-nullable types, use `?` only when null is valid
- Use `late` sparingly — prefer constructor initialization

## Flutter Widgets

- Keep widgets small and focused — extract when exceeding ~50 lines
- Use `const` constructors wherever possible to optimize rebuilds
- Prefer composition over inheritance for widget customization
- Use `StatelessWidget` by default, `StatefulWidget` only when managing local state
- Extract widget methods only if they need `BuildContext` — otherwise use functions

## State Management

- Use `setState` for simple, widget-local state
- Use `Provider` or `Riverpod` for shared/app-level state
- Use `ValueNotifier`/`ValueListenableBuilder` for simple reactive values
- Keep business logic out of widgets — use separate classes/services
- Use `ChangeNotifier` for observable state containers

## Navigation

- Use `go_router` for declarative routing
- Define routes as constants to avoid magic strings
- Use path parameters for required data, query parameters for optional filters
- Handle deep links with proper URL structure

## Error Handling

- Use `try-catch` for synchronous errors
- Use `.catchError()` or `try-catch` with `await` for async errors
- Create custom exception classes for domain-specific errors
- Show user-friendly error messages — log technical details

## Naming

- Types/Classes: `PascalCase`
- Functions/variables: `camelCase`
- Constants: `camelCase` (Dart convention, not SCREAMING_SNAKE)
- Files: `snake_case.dart`
- Private members: prefix with `_`

## Avoid

- **`dynamic` type** — Loses type safety; use proper types or `Object` with type checks
- **`late` without justification** — Can cause runtime errors; prefer constructor initialization
- **`setState` for cross-widget state** — Use Provider, Riverpod, or other state management
- **Huge `build()` methods** — Extract widgets; improves readability and rebuild performance
- **Null assertion operator (!)** — Use ?? with defaults or null-aware operators
- **Mutable global state** — Use scoped state management; globals make testing difficult
- **`print()` for logging** — Use `debugPrint()` or a logging package for production
- **Inline styles for repeated values** — Define in `ThemeData` or constants
- **Blocking the UI thread** — Use `compute()` or isolates for heavy computation
- **String concatenation for large texts** — Use `StringBuffer` or string interpolation
