# CSS Methodologies

## BEM (Block Element Modifier)
```css
.card { }
.card__title { }
.card__body { }
.card--featured { }
.card--featured .card__title { }
```

## CSS Modules
```css
/* Button.module.css */
.base { padding: 8px 16px; border-radius: 4px; }
.primary { composes: base; background: var(--color-primary); }
.secondary { composes: base; background: var(--color-secondary); }
```

## Utility-First (Tailwind)
```html
<button class="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">
  Submit
</button>
```

## When to Use What
- **BEM**: Traditional projects, server-rendered, no build tooling for CSS
- **CSS Modules**: Component-based frameworks with build step
- **Tailwind**: Rapid prototyping, design system enforcement, utility preference
- **CSS-in-JS**: When the framework ecosystem expects it (e.g., styled-components)
