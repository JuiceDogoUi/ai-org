---
name: svelte
description: Svelte and SvelteKit conventions, reactivity patterns, and component architecture. Use when working with Svelte applications or SvelteKit.
user-invocable: false
---

# Svelte Conventions

## Components

- One component per `.svelte` file
- Keep components small and focused — extract when exceeding ~50 lines
- Use `<script>`, `<style>`, and markup sections in that order
- Styles are scoped by default — use `:global()` sparingly

## Reactivity

### Svelte 4 (runes mode off)
- Use `let` for reactive variables
- Use `$:` for reactive declarations and statements
- Use `$: { }` blocks for reactive side effects

### Svelte 5 (runes mode)
- Use `$state()` for reactive state
- Use `$derived()` for computed values; `$derived.by()` for complex logic
- Use `$effect()` for side effects — return cleanup function for teardown
- Use `$props()` for component props with destructuring: `let { name, count = 0 } = $props()`
- Use `$bindable()` for two-way binding with parent components
- Use `$inspect()` for debugging reactive state (dev only)

## State Management

- Use component-level state for local concerns
- Use Svelte stores (`writable`, `readable`, `derived`) for shared state
- Access store values with `$` prefix in components
- Keep stores focused — one store per domain/feature

## Props & Events

- Define props with `export let` (Svelte 4) or `$props()` (Svelte 5)
- Use `createEventDispatcher()` for custom events (Svelte 4)
- Use callback props for events (Svelte 5)
- Use `bind:` for two-way binding sparingly

## SvelteKit Specifics

- Use file-based routing in `src/routes/`
- Use `+page.svelte` for pages, `+layout.svelte` for layouts
- Use `+page.ts` / `+page.server.ts` for load functions
- Use form actions for mutations (`+page.server.ts`)
- Use `$app/stores` for page, navigating, and updated stores

## Avoid

- **Overusing `:global()`** — Breaks scoping; use sparingly for third-party component overrides
- **Complex logic in templates** — Extract to reactive declarations or functions
- **`bind:` for everything** — Two-way binding adds complexity; prefer one-way when possible
- **Manual subscriptions without cleanup** — Use `$` auto-subscription or `onDestroy` for cleanup
- **`on:click` on non-interactive elements** — Use `<button>` or add proper ARIA roles for accessibility
- **Mixing Svelte 4 and Svelte 5 patterns** — Pick one reactivity model per project
- **Large components** — Extract when exceeding ~50 lines
- **Inline styles for repeated values** — Use CSS custom properties or classes
- **`goto()` in load functions** — Use `redirect()` from `@sveltejs/kit` instead
