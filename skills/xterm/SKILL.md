---
name: xterm
description: xterm.js terminal emulator integration, addons, and PTY communication. Use when building terminal interfaces in web or Electron applications.
user-invocable: false
---

# xterm.js Conventions

> **Documentation Freshness**: Always check the official xterm.js documentation
> (xtermjs.org) before generating code. Package names moved to the `@xterm/` scope —
> verify current import paths and addon APIs.

## Basic Setup

```typescript
import { Terminal } from '@xterm/xterm';
import '@xterm/xterm/css/xterm.css';

const terminal = new Terminal({
  cursorBlink: true,
  fontSize: 14,
  fontFamily: 'Menlo, Monaco, monospace'
});

terminal.open(document.getElementById('terminal'));
terminal.write('Welcome to the terminal\r\n');
```

## Core Concepts

- **Terminal** — The UI component rendering terminal output
- **Addons** — Optional features (fit, webgl, search, etc.)
- **PTY** — Backend process (node-pty, server-side) providing shell
- **Data flow** — PTY stdout → Terminal.write(), Terminal.onData → PTY stdin

## Essential Addons

```typescript
import { FitAddon } from '@xterm/addon-fit';
import { WebglAddon } from '@xterm/addon-webgl';
import { SearchAddon } from '@xterm/addon-search';
import { WebLinksAddon } from '@xterm/addon-web-links';

const fitAddon = new FitAddon();
terminal.loadAddon(fitAddon);
fitAddon.fit(); // Resize to container

const webglAddon = new WebglAddon();
terminal.loadAddon(webglAddon); // GPU-accelerated rendering

const searchAddon = new SearchAddon();
terminal.loadAddon(searchAddon);
searchAddon.findNext('pattern');
```

## Resize Handling

```typescript
const fitAddon = new FitAddon();
terminal.loadAddon(fitAddon);

// Fit on load
fitAddon.fit();

// Fit on window resize
window.addEventListener('resize', () => fitAddon.fit());

// Notify PTY of new dimensions
terminal.onResize(({ cols, rows }) => {
  pty.resize(cols, rows);
});
```

## PTY Integration (Node.js/Electron)

### Backend (main process)
```typescript
import * as pty from 'node-pty';

const shell = process.platform === 'win32' ? 'powershell.exe' : 'bash';
const ptyProcess = pty.spawn(shell, [], {
  name: 'xterm-color',
  cols: 80,
  rows: 24,
  cwd: process.cwd(),
  env: process.env
});

// Send output to frontend
ptyProcess.onData((data) => {
  mainWindow.webContents.send('terminal-output', data);
});

// Receive input from frontend
ipcMain.on('terminal-input', (event, data) => {
  ptyProcess.write(data);
});

// Handle resize
ipcMain.on('terminal-resize', (event, { cols, rows }) => {
  ptyProcess.resize(cols, rows);
});
```

### Frontend (renderer)
```typescript
// Send user input to PTY
terminal.onData((data) => {
  window.api.sendInput(data);
});

// Receive output from PTY
window.api.onOutput((data) => {
  terminal.write(data);
});
```

## WebSocket Integration (Web)

```typescript
const socket = new WebSocket('wss://server/terminal');

socket.onmessage = (event) => {
  terminal.write(event.data);
};

terminal.onData((data) => {
  socket.send(data);
});

terminal.onResize(({ cols, rows }) => {
  socket.send(JSON.stringify({ type: 'resize', cols, rows }));
});
```

## Theming

Pass a `theme` object to the Terminal constructor with `background`, `foreground`, `cursor`, `selectionBackground`, and the 16 ANSI color keys (`black` through `brightWhite`). Use the project's design tokens for colors — check the xterm.js docs for the full `ITheme` interface.

## Selection & Copy/Paste

```typescript
// Enable right-click paste
terminal.attachCustomKeyEventHandler((event) => {
  if (event.type === 'keydown' && event.ctrlKey && event.key === 'v') {
    navigator.clipboard.readText().then(text => terminal.paste(text));
    return false; // Prevent default
  }
  return true;
});

// Get selected text
const selection = terminal.getSelection();

// Copy to clipboard
terminal.onSelectionChange(() => {
  const selected = terminal.getSelection();
  if (selected) navigator.clipboard.writeText(selected);
});
```

## Performance

- Set `scrollback` to a reasonable limit (e.g., 1000) — unbounded scrollback consumes memory indefinitely
- Use the WebGL addon for large outputs — handle `onContextLoss` with a fallback to the canvas renderer
- Configure `fastScrollModifier` and `fastScrollSensitivity` for user preference

## Accessibility

```typescript
const terminal = new Terminal({
  screenReaderMode: true  // Enable screen reader support
});
```

## Cleanup

```typescript
// When unmounting
terminal.dispose();
// Also dispose addons if needed
fitAddon.dispose();
webglAddon.dispose();
```

## Avoid

- **Missing FitAddon** — Terminal won't resize with container; always use fit addon
- **Ignoring resize events** — PTY needs to know terminal dimensions for wrapping
- **Writing raw user input to PTY** — Input already goes through onData; don't duplicate
- **Blocking main thread** — Large writes should be chunked or use requestAnimationFrame
- **Missing xterm.css** — Terminal will render incorrectly without styles
- **Sync clipboard access** — Use async clipboard API; sync is deprecated
- **Ignoring WebGL context loss** — Handle with fallback to canvas renderer
- **Unbounded scrollback** — Memory grows indefinitely; set reasonable limit
- **Direct DOM access** — Use terminal API; DOM structure is internal
- **Missing dispose()** — Memory leak; always clean up terminal on unmount
