# JavaScript Patterns

## Module Pattern

Use closures to encapsulate state with a public API. Export a factory function that returns an object with getter/setter/subscribe methods — keeps internal state private while exposing controlled access.

## Deep Clone

Use `structuredClone(obj)` for deep cloning. Handles nested objects, arrays, Maps, Sets, Dates, and circular references. Check MDN for unsupported types (functions, DOM nodes, symbols).

## Proxy-Based Observable

Use `Proxy` with a `set` trap to intercept property changes and trigger callbacks. Useful for reactive data binding in vanilla JS. Note: Proxies add overhead — use only when change detection is needed.
