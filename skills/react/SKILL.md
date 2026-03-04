---
name: react
description: React framework conventions, hooks patterns, and component architecture. Use when working with React applications, components, or Next.js.
user-invocable: false
---

# React Conventions

> **Documentation Freshness**: Always check the official React documentation
> (react.dev) before generating code. React 19 introduced new hooks and patterns —
> verify current APIs, especially Server Components and Actions.

## Components

- Use functional components exclusively (no class components)
- Keep components small and focused — extract when exceeding ~50 lines
- Co-locate related files (component, styles, tests, types)
- Use named exports for components, default export only for pages (Next.js)

## Hooks

- Follow the Rules of Hooks (top level, React functions only)
- Use `useState` for local component state
- Use `useReducer` for complex state with multiple sub-values
- Use `useMemo` and `useCallback` only when needed (premature optimization is common)
- Extract custom hooks for reusable stateful logic

### React 19 Hooks
- `useActionState` — Manage async actions with pending state and error handling
- `useOptimistic` — Optimistic UI updates while requests are pending
- `useFormStatus` — Access form submission status from child components
- `use()` — Read promises and context directly in render (replaces some useEffect patterns)

## State Management

- Lift state to the lowest common ancestor
- Use Context for low-frequency updates (theme, auth, locale)
- Use external stores (Zustand, Redux Toolkit, Jotai) for frequent updates
- Avoid prop drilling beyond 2-3 levels — consider composition or context

## Data Fetching

- Use React Query / TanStack Query or SWR for server state
- Keep server state separate from client state
- Handle loading, error, and empty states explicitly
- Prefetch data for predictable navigations

## Patterns

- Prefer composition over render props or HOCs
- Use children prop for flexible layouts
- Use compound components for related UI elements
- Keep business logic out of components — use hooks or services

## Next.js Specifics

- Use App Router conventions (page.tsx, layout.tsx, loading.tsx)
- Prefer Server Components by default, Client Components when needed
- Use Server Actions for mutations
- Handle metadata in layout or page files

### Server Components
- Fetch data directly in Server Components (no useEffect needed)
- Keep Client Components small and "leaf-level" to minimize JS shipped
- Use `loading.tsx` and `error.tsx` for streaming/Suspense boundaries
- Default fetch is cached; use `{ cache: 'no-store' }` for dynamic data
- Use `{ next: { revalidate: N } }` for time-based caching

## React Native Specifics

- Use `StyleSheet.create()` for styles — not CSS
- Flexbox is the primary layout system (defaults differ from web: `flexDirection: 'column'`)
- Use platform-specific extensions (`.ios.tsx`, `.android.tsx`) or `Platform.select()`
- No CSS cascade — styles don't inherit except for text within Text components
- Use `Dimensions` or `useWindowDimensions` for responsive layouts
- Touch targets: minimum 44pt for accessibility

## Avoid

- **Class components** — Use functional components with hooks exclusively
- **Mutating state directly** — Always use setter functions; never `state.push()` or `state.x = y`
- **Array index as key** — Use stable, unique IDs; index causes bugs with reordering
- **Excessive `useMemo`/`useCallback`** — Premature optimization; measure before optimizing
- **Prop drilling beyond 2-3 levels** — Use Context, composition, or state management
- **`dangerouslySetInnerHTML`** — Sanitize content or avoid entirely; XSS risk
- **`useEffect` for derived state** — Use `useMemo` or compute inline; effects cause extra renders
- **`useEffect` as event handler** — Call handlers directly in events, not in effects
- **Missing/incorrect dependency arrays** — Include all dependencies; use ESLint plugin
- **Large components** — Extract when exceeding ~50 lines; improves readability and testing
- **Inline object/array props** — Creates new reference each render; extract to variables or memoize
- **`forwardRef` without `useImperativeHandle`** — Exposes entire DOM node; limit to needed methods
