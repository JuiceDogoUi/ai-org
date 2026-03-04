# TypeScript Patterns Reference

## Discriminated Unions
```typescript
type Result<T, E = Error> =
  | { success: true; data: T }
  | { success: false; error: E };
```

## Branded Types
```typescript
type UserId = string & { readonly __brand: unique symbol };
function createUserId(id: string): UserId {
  return id as UserId;
}
```

## Builder Pattern

Use method chaining with `return this` for fluent APIs. Each method mutates internal state and returns `this` for chaining. Type the builder as a generic class for type-safe query/config construction.

## Type-Safe Event Emitter
```typescript
type EventMap = {
  'user:created': { id: string; email: string };
  'user:deleted': { id: string };
};
class TypedEmitter<T extends Record<string, unknown>> {
  on<K extends keyof T>(event: K, handler: (payload: T[K]) => void): void;
  emit<K extends keyof T>(event: K, payload: T[K]): void;
}
```

## Exhaustive Switch
```typescript
function assertNever(value: never): never {
  throw new Error(`Unexpected value: ${value}`);
}
```
