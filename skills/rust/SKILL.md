---
name: rust
description: Rust language conventions, ownership patterns, and systems programming. Use when working with Rust code, Tauri backends, or performance-critical systems.
user-invocable: false
---

# Rust Conventions

> **Documentation Freshness**: Always check docs.rs for crate APIs and
> doc.rust-lang.org for language features. The async ecosystem and error
> handling crates evolve rapidly — verify current versions and patterns.

## Language

- Prefer borrowing (`&T`, `&mut T`) over ownership transfer when possible
- Use `Result<T, E>` for recoverable errors, `panic!` only for unrecoverable bugs
- Prefer iterators and combinators over manual loops
- Use `Option<T>` instead of null — never use sentinel values
- Derive common traits: `Debug`, `Clone`, `PartialEq` where appropriate
- Use `impl Trait` for return types when the concrete type is an implementation detail

## Ownership & Borrowing

- Follow the single-owner principle — each value has exactly one owner
- Use references for temporary access, cloning for independent copies
- Prefer `&str` over `String` in function parameters when possible
- Use `Cow<'_, str>` when you might or might not need to own
- Understand lifetimes — annotate only when the compiler requires it

## Error Handling

- Define error types as enums implementing `std::error::Error`
- Use `thiserror` for library error types, `anyhow` for application errors
- Propagate errors with `?` operator — handle at the appropriate level
- Provide context with `.context()` or `.with_context()` (anyhow)

## Async (Tokio)

- Use `async`/`await` for I/O-bound operations
- Spawn tasks with `tokio::spawn` for concurrent work
- Use channels (`mpsc`, `oneshot`) for task communication
- Prefer `tokio::select!` for waiting on multiple futures

## Tauri Specifics

- Use `#[tauri::command]` for functions callable from frontend
- Return `Result<T, String>` or custom error types from commands
- Use Tauri's state management for shared application state
- Configure permissions explicitly in `tauri.conf.json`
- For Tauri-specific frontend/backend integration patterns, see `tauri` skill

## Naming

- Types/Traits: `PascalCase`
- Functions/variables: `snake_case`
- Constants: `SCREAMING_SNAKE_CASE`
- Lifetimes: short lowercase (`'a`, `'b`) or descriptive (`'ctx`)

## Avoid

- **`.unwrap()` in production code** — Use `?`, `expect()` with context, or proper error handling
- **`unsafe` without justification** — Document why it's necessary and prove invariants are upheld
- **`.clone()` for convenience** — Cloning to satisfy borrow checker usually indicates design issue
- **`RefCell`/`Rc` everywhere** — Interior mutability is a last resort; redesign ownership first
- **`String` parameters when `&str` suffices** — Accept borrows when you don't need ownership
- **Ignoring `Result`** — Handle errors or use `let _ =` to explicitly discard
- **`#[allow(unused)]` without reason** — Remove unused code or document why it exists
- **Blocking in async context** — Use `tokio::spawn_blocking` for blocking operations
- **`panic!` for recoverable errors** — Reserve for bugs, not expected error conditions
- **Lifetime annotations when elision works** — Let the compiler infer when possible
