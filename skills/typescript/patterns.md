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
```typescript
class QueryBuilder<T> {
  private filters: Filter[] = [];
  where(filter: Filter): this {
    this.filters.push(filter);
    return this;
  }
  build(): Query<T> { /* ... */ }
}
```

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
