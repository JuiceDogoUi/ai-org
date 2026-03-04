---
name: electron
description: Electron desktop app conventions, IPC patterns, and security. Use when building cross-platform desktop applications with web technologies.
user-invocable: false
---

# Electron Conventions

> **Documentation Freshness**: Always check the official Electron documentation
> (electronjs.org/docs) before generating code. Security defaults and API availability
> change between major versions — verify IPC patterns and BrowserWindow options.

## Architecture

- **Main process** — Node.js environment, manages windows, system access
- **Renderer process** — Chromium, runs web UI, sandboxed by default
- **Preload scripts** — Bridge between main and renderer, expose safe APIs
- Use context isolation — renderer cannot access Node.js directly

## Process Communication (IPC)

### Renderer → Main
```javascript
// preload.js - expose specific channels
contextBridge.exposeInMainWorld('api', {
  saveFile: (data) => ipcRenderer.invoke('save-file', data)
});

// main.js - handle the call
ipcMain.handle('save-file', async (event, data) => {
  // perform file operation
});
```

### Main → Renderer
```javascript
// main.js - send to specific window
mainWindow.webContents.send('update-available', version);

// preload.js - expose listener
contextBridge.exposeInMainWorld('api', {
  onUpdateAvailable: (callback) => ipcRenderer.on('update-available', callback)
});
```

## Security

- **Enable context isolation** — `contextIsolation: true` (default in Electron 12+)
- **Disable node integration** — `nodeIntegration: false` in renderer
- **Use preload scripts** — Expose only needed APIs via `contextBridge`
- **Validate IPC inputs** — Treat renderer messages as untrusted
- **Enable sandbox** — `sandbox: true` for renderer processes
- **Set strict CSP** — No `unsafe-inline`, no `unsafe-eval`

## Window Management

- Create windows lazily when needed
- Handle window lifecycle events (close, minimize, focus)
- Save and restore window bounds for user preference
- Use `BrowserWindow.loadFile()` for local content, `loadURL()` for remote

## File System

- Use `app.getPath()` for standard directories (userData, documents, temp)
- Store user data in `app.getPath('userData')`
- Use `dialog.showOpenDialog()` and `dialog.showSaveDialog()` for file pickers
- Handle file operations in main process, not renderer

## Native Features

- **Menus** — Use `Menu.buildFromTemplate()` for app and context menus
- **Tray** — Create system tray icons with `Tray`
- **Notifications** — Use `Notification` API in renderer or main
- **Global shortcuts** — Register with `globalShortcut` (unregister on quit)
- **Deep links** — Handle with `app.setAsDefaultProtocolClient()`

## Updates

- Use `electron-updater` with `autoUpdater`
- Check for updates on app launch and periodically
- Show update available notification, don't force restart
- Test update flow before release

## Packaging

- Use `electron-builder` or `electron-forge`
- Configure platform-specific options (icons, signing, notarization)
- Code sign for macOS and Windows distribution
- Notarize macOS apps for Gatekeeper

## Performance

- Lazy load heavy modules in main process
- Use web workers for CPU-intensive renderer work
- Minimize IPC traffic — batch messages when possible
- Profile with Chrome DevTools and `process.getHeapStatistics()`

## Avoid

- **`nodeIntegration: true`** — Security risk; use preload scripts instead
- **`contextIsolation: false`** — Required for security; never disable
- **`webSecurity: false`** — Disables same-origin policy; never in production
- **`remote` module** — Deprecated and insecure; use IPC instead
- **Exposing entire Node APIs** — Only expose specific, validated methods
- **Synchronous IPC (`sendSync`)** — Blocks renderer; use `invoke` instead
- **Storing secrets in renderer** — Keep credentials in main process or secure storage
- **Shell.openExternal with untrusted URLs** — Validate URLs to prevent command injection
- **Ignoring app lifecycle** — Handle `before-quit`, `will-quit` for cleanup
- **Bundling unnecessary files** — Use `asar` and exclude dev dependencies
