---
name: codemirror
description: CodeMirror 6 editor integration, extensions, and customization. Use when building code editors or syntax-highlighted input fields.
user-invocable: false
---

# CodeMirror 6 Conventions

## Architecture

CodeMirror 6 is modular and functional — compose features from small packages.

- **EditorState** — Immutable state containing document, selection, extensions
- **EditorView** — DOM component that renders state and handles input
- **Extensions** — Composable features (language, keymaps, themes)
- **Transactions** — State updates dispatched to the view

## Basic Setup

```typescript
import { EditorState } from '@codemirror/state';
import { EditorView, basicSetup } from 'codemirror';

const state = EditorState.create({
  doc: 'initial content',
  extensions: [basicSetup]
});

const view = new EditorView({
  state,
  parent: document.getElementById('editor')
});
```

## Extensions

### Composition
Extensions are arrays that can be nested and flattened:

```typescript
const mySetup = [
  lineNumbers(),
  highlightActiveLineGutter(),
  history(),
  myCustomExtension
];

// Use in state
EditorState.create({ extensions: mySetup });
```

### Common Extensions
- `basicSetup` — Line numbers, history, bracket matching, etc.
- `minimalSetup` — Lighter alternative to basicSetup
- `lineNumbers()` — Show line numbers
- `history()` — Undo/redo support
- `bracketMatching()` — Highlight matching brackets
- `closeBrackets()` — Auto-close brackets and quotes
- `autocompletion()` — Code completion popup

## Language Support

```typescript
import { javascript } from '@codemirror/lang-javascript';
import { python } from '@codemirror/lang-python';

// Add language to extensions
EditorState.create({
  extensions: [javascript({ typescript: true })]
});
```

### Dynamic Language Switching
Use compartments for reconfigurable extensions:

```typescript
import { Compartment } from '@codemirror/state';

const languageConf = new Compartment();

// Initial setup
const state = EditorState.create({
  extensions: [languageConf.of(javascript())]
});

// Switch language
view.dispatch({
  effects: languageConf.reconfigure(python())
});
```

## Themes

```typescript
import { oneDark } from '@codemirror/theme-one-dark';

// Add to extensions
EditorState.create({
  extensions: [oneDark]
});
```

### Custom Themes
```typescript
import { EditorView } from '@codemirror/view';

const myTheme = EditorView.theme({
  '&': { height: '100%' },
  '.cm-content': { fontFamily: 'monospace' },
  '.cm-line': { padding: '0 4px' }
});
```

## State Updates

### Reading State
```typescript
const doc = view.state.doc.toString();
const selection = view.state.selection.main;
const cursorPos = selection.head;
```

### Dispatching Changes
```typescript
// Replace entire document
view.dispatch({
  changes: { from: 0, to: view.state.doc.length, insert: newContent }
});

// Insert at cursor
view.dispatch({
  changes: { from: selection.head, insert: 'text' }
});

// Set selection
view.dispatch({
  selection: { anchor: 0, head: 10 }
});
```

## Event Handling

### Update Listener
```typescript
EditorView.updateListener.of((update) => {
  if (update.docChanged) {
    console.log('Document changed');
  }
  if (update.selectionSet) {
    console.log('Selection changed');
  }
});
```

### DOM Events
```typescript
EditorView.domEventHandlers({
  blur: (event, view) => {
    // Handle blur
  },
  keydown: (event, view) => {
    // Return true to prevent default handling
  }
});
```

## Custom Extensions

### State Field
```typescript
import { StateField, StateEffect } from '@codemirror/state';

const addMarker = StateEffect.define<{pos: number}>();

const markerField = StateField.define({
  create: () => [],
  update(markers, tr) {
    for (let e of tr.effects) {
      if (e.is(addMarker)) {
        markers = [...markers, e.value.pos];
      }
    }
    return markers;
  }
});
```

### View Plugin
```typescript
import { ViewPlugin, Decoration } from '@codemirror/view';

const highlightPlugin = ViewPlugin.fromClass(class {
  decorations = Decoration.none;

  update(update) {
    if (update.docChanged || update.selectionSet) {
      this.decorations = this.buildDecorations(update.view);
    }
  }
}, { decorations: v => v.decorations });
```

## Keybindings

```typescript
import { keymap } from '@codemirror/view';
import { defaultKeymap, historyKeymap } from '@codemirror/commands';

const customKeymap = keymap.of([
  { key: 'Mod-s', run: () => { save(); return true; } },
  ...defaultKeymap,
  ...historyKeymap
]);
```

## Read-Only Mode

```typescript
import { EditorState } from '@codemirror/state';

EditorState.create({
  extensions: [EditorState.readOnly.of(true)]
});

// Toggle dynamically with compartment
const readOnlyConf = new Compartment();
view.dispatch({
  effects: readOnlyConf.reconfigure(EditorState.readOnly.of(false))
});
```

## Avoid

- **Direct DOM manipulation** — Use transactions and extensions; DOM is managed by CodeMirror
- **Mutating state directly** — State is immutable; dispatch transactions
- **Storing view in React state** — Store ref instead; view is mutable
- **Heavy work in update listeners** — Debounce expensive operations
- **`basicSetup` when you need control** — Build your own extension set for customization
- **Ignoring cleanup** — Call `view.destroy()` when unmounting
- **Synchronous large document updates** — Use `requestAnimationFrame` or chunking
- **Mixing CM5 and CM6 patterns** — CM6 is a complete rewrite; forget CM5 APIs
