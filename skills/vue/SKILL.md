---
name: vue
description: Vue framework conventions, Composition API patterns, and component architecture. Use when working with Vue applications or Nuxt.
user-invocable: false
---

# Vue Conventions

> **Documentation Freshness**: Always check the official Vue documentation (vuejs.org)
> before generating code. Vue 3.5+ introduced reactive props destructuring and
> watcher improvements — verify current APIs for your target version.

## Components

- Use `<script setup>` syntax (Composition API)
- Keep components small and focused — extract when exceeding ~50 lines
- Use Single File Components (.vue) with scoped styles
- Co-locate related files (component, composables, tests)

## Composition API

- Define reactive state with `ref()` for primitives, `reactive()` for objects
- Use `computed()` for derived state
- Use `watch()` and `watchEffect()` sparingly — prefer computed when possible
- Extract reusable logic into composables (`use*` naming convention)

### Vue 3.5+ Features
- Reactive props destructuring: `const { foo = 'default' } = defineProps<{ foo?: string }>()`
- Use `onWatcherCleanup()` for cleaner side-effect cleanup in watchers
- Limit deep watcher traversal with `{ deep: 2 }` for performance

## State Management

- Use `ref`/`reactive` for local component state
- Use Pinia for shared application state
- Keep stores focused — one store per domain/feature
- Use `storeToRefs()` to maintain reactivity when destructuring

## Props & Events

- Define props with `defineProps<T>()` for type safety
- Define emits with `defineEmits<T>()`
- Use `v-model` with `defineModel()` for two-way binding
- Prefer events over mutating props

## Patterns

- Use `provide`/`inject` for dependency injection (theme, services)
- Use slots for flexible component composition
- Use async components for code splitting
- Keep template logic simple — move complex logic to computed or methods

## Nuxt Specifics

- Use file-based routing in `pages/` directory
- Use `useFetch` or `useAsyncData` for data fetching
- Use `useState` for SSR-safe shared state
- Define layouts in `layouts/` directory

## Avoid

- **Mixing Options API and Composition API** — Pick one style per project for consistency
- **Mutating props** — Props are read-only; emit events to update parent
- **`this` in `<script setup>`** — No `this` context in Composition API; use refs directly
- **Deep watchers on large objects** — Performance hit; watch specific properties or use `watchEffect`
- **`$refs` for parent-child communication** — Use props/emits; refs are for DOM/component access
- **Reactive objects in `v-for` keys** — Use primitive, stable IDs
- **`v-if` with `v-for` on same element** — `v-for` has higher priority; wrap in template or compute filtered list
- **Global event bus** — Use Pinia stores or provide/inject for cross-component state
- **`setTimeout` in lifecycle hooks without cleanup** — Use `onUnmounted` to clear timers
