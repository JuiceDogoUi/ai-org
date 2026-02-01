---
name: angular
description: Angular framework conventions, component patterns, and architecture. Use when working with Angular applications, components, services, or modules.
user-invocable: false
---

# Angular Conventions

## Architecture

- Follow the Angular style guide for file naming: `feature.type.ts`
- Use standalone components (default since Angular 17+)
- Organize by feature, not by type (group related components, services, models together)
- Use lazy-loaded routes for feature modules
- Keep components lean -- delegate logic to services

## Components

- Prefer signals over `Input()`/`Output()` decorators (Angular 17+)
- Use `input()`, `output()`, and `model()` signal-based APIs
- Use `computed()` for derived state
- Use `effect()` sparingly -- prefer declarative data flow
- Use `ChangeDetectionStrategy.OnPush` for all components
- Keep templates readable -- extract complex logic to the component class

## Services

- Use `providedIn: 'root'` for singleton services
- Use `inject()` function over constructor injection
- Handle HTTP errors in services, not components
- Use RxJS for complex async flows, signals for simple state

## Reactive Patterns

- Prefer signals for synchronous state
- Use RxJS for HTTP, WebSocket, and event streams
- Use `toSignal()` and `toObservable()` for interop
- Avoid nested subscriptions -- use `switchMap`, `mergeMap`, `concatMap`

For component patterns, see [patterns.md](patterns.md).
For testing strategies, see [testing.md](testing.md).
