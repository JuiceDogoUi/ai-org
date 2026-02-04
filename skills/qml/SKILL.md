---
name: qml
description: QML and Qt Quick conventions, component patterns, and property bindings. Use when building Qt-based UIs with QML.
user-invocable: false
---

# QML Conventions

## Language Basics

- QML is declarative — describe what, not how
- Use property bindings for reactive updates
- Prefer declarative bindings over imperative JavaScript
- Keep JavaScript blocks minimal — complex logic goes in C++
- Use `id` for element references within the same file

## Component Structure

```qml
import QtQuick
import QtQuick.Controls

Item {
    id: root

    // Public properties (API)
    property string title: ""
    property bool enabled: true

    // Signals (API)
    signal clicked()

    // Private properties
    property int _internalState: 0

    // Child elements
    Text {
        text: root.title
    }
}
```

## Properties

- Declare public properties at top of component
- Use `readonly property` for computed/derived values
- Use `required property` (Qt 6) for mandatory properties
- Prefix private properties with underscore: `_privateValue`
- Use property aliases for exposing nested properties

## Bindings

- Prefer bindings over assignments: `width: parent.width * 0.5`
- Use ternary for conditional bindings: `color: enabled ? "blue" : "gray"`
- Avoid binding loops — ensure no circular dependencies
- Use `Qt.binding()` to restore bindings after imperative changes
- Keep binding expressions simple — extract complex logic to functions

## Signals and Handlers

- Define signals for component events: `signal clicked()`
- Use `on<Signal>:` handlers to respond to signals
- Emit signals with `signalName()` call
- Prefer signals over direct function calls for loose coupling
- Use Connections for dynamic signal connections

## Layouts

- Use `ColumnLayout`, `RowLayout`, `GridLayout` for automatic positioning
- Use anchors for relative positioning: `anchors.fill: parent`
- Avoid mixing anchors and manual positioning
- Use `Layout.fillWidth`, `Layout.preferredWidth` in layouts
- Prefer layouts over manual coordinate calculation

## Components and Reuse

- One component per file, filename matches component name
- Use `Component` for inline component definitions
- Use `Loader` for lazy loading and dynamic component creation
- Use `Repeater` for generating items from models
- Extract reusable components to separate files

## Models and Views

- Use `ListModel` for QML-defined data
- Use `ListView`, `GridView`, `Repeater` for displaying models
- Define delegates as separate components for complex items
- Use `modelData` for simple models, named roles for complex ones
- Implement C++ models for large datasets

## C++ Integration

- Expose C++ objects to QML via `setContextProperty()` or `qmlRegisterType()`
- Use `Q_PROPERTY` for bindable C++ properties
- Use `Q_INVOKABLE` for callable C++ methods
- Emit signals from C++ for QML handlers
- Use QML singletons for app-wide services

## States and Transitions

- Use `states` array for discrete component states
- Use `State` with `PropertyChanges` for state definitions
- Use `transitions` for animated state changes
- Prefer states over imperative property toggling
- Keep state logic simple — complex logic in C++

## Performance

- Use `asynchronous: true` for Image loading
- Use `Loader` to defer component creation
- Minimize JavaScript in bindings
- Use `ShaderEffect` sparingly — can impact performance
- Profile with Qt Creator's QML Profiler

## Avoid

- **Complex JavaScript in bindings** — Extract to functions or C++
- **Binding loops** — Ensure no circular dependencies
- **Hardcoded sizes** — Use relative sizing and layouts
- **Deep component nesting** — Extract to separate components
- **Direct parent property access** — Use explicit property APIs
- **Imperative style** — Embrace declarative bindings
- **Global JavaScript variables** — Use properties and context
- **Blocking operations in QML** — Use C++ workers for heavy tasks
- **Unused imports** — Remove to improve load time
- **Anonymous signal handlers** — Name handlers for clarity
