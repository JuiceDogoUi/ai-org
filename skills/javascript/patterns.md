# JavaScript Patterns

## Module Pattern
```javascript
export function createStore(initialState) {
  let state = { ...initialState };
  const listeners = new Set();

  return {
    getState: () => ({ ...state }),
    setState(update) {
      state = { ...state, ...update };
      listeners.forEach(fn => fn(state));
    },
    subscribe(fn) {
      listeners.add(fn);
      return () => listeners.delete(fn);
    }
  };
}
```

## Deep Clone
```javascript
export function deepClone(obj) {
  return structuredClone(obj);
}
```

## Proxy-Based Observable
```javascript
export function observable(target, onChange) {
  return new Proxy(target, {
    set(obj, prop, value) {
      const old = obj[prop];
      obj[prop] = value;
      if (old !== value) onChange(prop, value, old);
      return true;
    }
  });
}
```
