---
name: tauri
description: Tauri desktop framework patterns, IPC, commands, and configuration. Use when building Tauri desktop applications with Rust backend and web frontend.
user-invocable: false
---

# Tauri Conventions

> **Documentation Freshness**: Tauri v2 introduced a new permissions model, plugin
> system, and mobile support. APIs differ significantly from v1. Check v2.tauri.app
> for current documentation.

## Architecture

- Tauri apps have two parts: Rust backend (`src-tauri/`) and web frontend (`src/`)
- Frontend runs in a webview, backend handles system operations
- Communication via IPC: frontend invokes commands, backend responds
- Use Tauri's event system for backend-to-frontend notifications
- Keep heavy computation and I/O in Rust, UI in frontend framework

## Commands

- Define commands with `#[tauri::command]`
- Commands are async by default — use `async` for I/O operations
- Return `Result<T, String>` for error handling (or custom error types)
- Use `State<T>` for shared application state
- Commands run on a separate thread pool — don't block the main thread

```rust
#[tauri::command]
async fn read_file(path: String) -> Result<String, String> {
    std::fs::read_to_string(&path)
        .map_err(|e| e.to_string())
}
```

## State Management

- Use `tauri::State<T>` for application-wide state
- Wrap state in `Mutex` or `RwLock` for thread-safe mutation
- Register state in `tauri::Builder::manage()`
- Access state in commands via parameter injection

```rust
struct AppState {
    counter: Mutex<i32>,
}

#[tauri::command]
fn increment(state: State<AppState>) -> i32 {
    let mut counter = state.counter.lock().unwrap();
    *counter += 1;
    *counter
}
```

## Events

- Use `app.emit_all()` or `window.emit()` for backend-to-frontend events
- Frontend listens with `listen()` from `@tauri-apps/api/event`
- Use events for notifications, progress updates, real-time data
- Events are fire-and-forget — use commands for request/response

## Configuration (tauri.conf.json)

- Configure window properties in `tauri.windows`
- Set permissions in `tauri.security.capabilities`
- Use environment-specific configs with `tauri.conf.json` and `tauri.{env}.conf.json`
- Bundle settings in `tauri.bundle`

## Frontend Integration

- Import from `@tauri-apps/api` for Tauri APIs
- Use `invoke()` to call Rust commands
- Use `convertFileSrc()` for local file URLs in webview
- Handle deep links, file associations in Rust side

```typescript
import { invoke } from '@tauri-apps/api/core';

const content = await invoke<string>('read_file', { path: '/path/to/file' });
```

## Permissions (Tauri v2)

- Capabilities define what plugins/APIs are accessible
- Configure in `src-tauri/capabilities/`
- Principle of least privilege — only enable what you need
- Scope file system access to specific directories

## Plugins

- Use official plugins: `@tauri-apps/plugin-*`
- Configure plugin permissions in capabilities
- Common plugins: fs, shell, dialog, notification, http
- Create custom plugins for reusable Rust functionality

## Build & Distribution

- Use `tauri build` for production builds
- Configure signing for each platform
- Set up auto-updater for update distribution
- Use `tauri icon` to generate app icons from source image

## Avoid

- **Blocking the main thread** — Use async commands for I/O
- **Large data transfers via IPC** — Stream or chunk large files
- **Hardcoded paths** — Use `app_data_dir()`, `resource_dir()` APIs
- **Unrestricted file system access** — Scope permissions to needed directories
- **Synchronous file operations** — Use async with Tokio
- **Exposing sensitive operations** — Validate all command inputs
- **Direct DOM manipulation from Rust** — Use events and state instead
- **Ignoring security warnings** — Address CSP and permission issues
