---
name: cpp
description: Modern C++ conventions, patterns, and best practices. Use when working with C++ code, systems programming, or performance-critical applications.
user-invocable: false
---

# C++ Conventions

## Modern C++ (C++17/20/23)

- Use `auto` for type deduction when type is obvious
- Use `constexpr` for compile-time evaluation
- Use `std::optional<T>` instead of nullable pointers
- Use `std::variant` for type-safe unions
- Use structured bindings: `auto [key, value] = pair;`
- Use range-based for loops: `for (const auto& item : container)`
- Use `std::span` for non-owning array views (C++20)

## Memory Management

- Prefer stack allocation over heap when possible
- Use smart pointers: `std::unique_ptr` (ownership), `std::shared_ptr` (shared)
- Use `std::make_unique` and `std::make_shared` for construction
- Follow RAII — resources acquired in constructor, released in destructor
- Avoid raw `new`/`delete` — use containers and smart pointers
- Use `std::string_view` for non-owning string references

## Error Handling

- Use exceptions for exceptional conditions
- Use `std::expected<T, E>` (C++23) or result types for expected failures
- Use `noexcept` for functions that cannot throw
- Throw by value, catch by const reference
- Define error hierarchies inheriting from `std::exception`

## Classes

- Use `= default` and `= delete` explicitly
- Follow Rule of 0/3/5 for resource management
- Mark single-argument constructors `explicit`
- Use member initializer lists, not assignment in constructor body
- Prefer composition over inheritance
- Use `override` for virtual function overrides
- Use `final` to prevent further inheritance/overriding

## Containers and Algorithms

- Prefer `std::vector` as default container
- Use `std::array` for fixed-size arrays
- Use `std::unordered_map` for O(1) lookup (when order doesn't matter)
- Prefer algorithms from `<algorithm>` over manual loops
- Use `std::ranges` (C++20) for cleaner pipelines
- Reserve capacity when final size is known

## Concurrency

- Use `std::thread` or `std::jthread` (C++20) for threads
- Use `std::mutex` with `std::lock_guard` or `std::scoped_lock`
- Use `std::atomic` for lock-free operations
- Use `std::async` and `std::future` for async operations
- Prefer higher-level abstractions over raw thread management

## Naming

- Types/Classes: `PascalCase`
- Functions/variables: `snake_case` or `camelCase` (project-dependent)
- Constants: `kPascalCase` or `SCREAMING_SNAKE_CASE`
- Member variables: `m_name` or `name_` prefix/suffix
- Macros (avoid if possible): `SCREAMING_SNAKE_CASE`

## Avoid

- **Raw pointers for ownership** — Use smart pointers
- **C-style casts** — Use `static_cast`, `dynamic_cast`, `const_cast`, `reinterpret_cast`
- **Macros for constants** — Use `constexpr` variables
- **`using namespace std;` in headers** — Pollutes global namespace
- **Passing large objects by value** — Use const reference
- **Manual memory management** — Use RAII and smart pointers
- **C-style arrays** — Use `std::array` or `std::vector`
- **`NULL`** — Use `nullptr`
- **Magic numbers** — Use named constants
- **Ignoring compiler warnings** — Fix them or explicitly suppress with reason
