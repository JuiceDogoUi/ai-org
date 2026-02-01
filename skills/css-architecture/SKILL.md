---
name: css-architecture
description: CSS/SCSS organization, methodologies, design tokens, and responsive patterns. Use when working with stylesheets, layouts, or design systems.
user-invocable: false
---

# CSS Architecture

## Organization
- One component = one stylesheet (co-located)
- Global styles: variables/tokens, reset, typography, utilities
- Keep specificity low -- avoid nesting beyond 3 levels
- Use design tokens for all values (colors, spacing, typography, shadows)

## Methodologies (match the project's existing approach)
- **BEM**: `.block__element--modifier`
- **CSS Modules**: Scoped by default, compose for sharing
- **Utility-first** (Tailwind): Compose utilities in markup
- **CSS-in-JS**: When framework requires it

## Responsive
- Mobile-first: base styles for mobile, `min-width` breakpoints for larger
- Use relative units (`rem`, `em`) over fixed (`px`) for text
- Use `clamp()` for fluid typography and spacing
- Test at standard breakpoints: 320, 768, 1024, 1440

## Performance
- Avoid `@import` in CSS (use bundler imports)
- Minimize use of expensive properties (`box-shadow`, `filter`, `backdrop-filter`)
- Use `will-change` sparingly and only when needed
- Prefer `transform` and `opacity` for animations (GPU-composited)

For methodologies detail, see [methodologies.md](methodologies.md).
For design tokens, see [design-tokens.md](design-tokens.md).
