---
name: accessibility
description: WCAG compliance, ARIA patterns, and accessibility best practices. Use when implementing or reviewing UI for accessibility.
user-invocable: false
---

# Accessibility (a11y)

> **Documentation Freshness**: Always check the official W3C WCAG specification
> (w3.org/WAI/WCAG22) and WAI-ARIA Authoring Practices (w3.org/WAI/ARIA/apg)
> before generating accessibility code. Standards evolve — verify current
> success criteria, conformance levels, and recommended patterns against the source.

## File Guide
- **This file** — Core principles, semantic HTML, and best practices
- **checklist.md** — Pre-ship verification checklist
- **aria-patterns.md** — ARIA widget implementations (tabs, dialogs, menus, comboboxes)
- **compliance-frameworks/wcag** — WCAG conformance levels, commonly failed criteria, and 2.2 changes

## WCAG Principles

1. **Perceivable**: Content available to all senses (alt text, captions, contrast)
2. **Operable**: All functionality via keyboard, sufficient time, no seizure triggers
3. **Understandable**: Readable, predictable, input assistance
4. **Robust**: Compatible with assistive technologies

For WCAG 2.2 additions (Focus Appearance, Dragging Movements, Target Size, Accessible Authentication, etc.), see `compliance-frameworks/wcag`.

## Semantic HTML

Use native HTML elements — they have built-in accessibility.

```html
<!-- Good: Semantic elements -->
<button type="submit">Save</button>
<nav aria-label="Main">...</nav>
<main>...</main>
<h1>Page Title</h1>

<!-- Bad: Div soup -->
<div class="btn" onclick="save()">Save</div>
<div class="nav">...</div>
```

### Key Elements
- `<button>` for clickable actions
- `<a href>` for navigation
- `<nav>`, `<main>`, `<aside>`, `<footer>` for landmarks
- `<h1>`-`<h6>` in logical order (don't skip levels)
- `<label>` associated with form inputs
- `<table>` with `<th>` for tabular data
- `<dialog>` for modals (handles focus trapping and Escape natively)

### Skip Link

Provide a skip link as the first focusable element so keyboard users can bypass navigation.

```html
<a href="#main-content" class="skip-link">Skip to main content</a>
<nav><!-- navigation --></nav>
<main id="main-content"><!-- page content --></main>
```

Visually hide the link off-screen; reveal it on focus with `position: fixed` or similar.

## Images

```html
<!-- Informative image: Describe content -->
<img src="chart.png" alt="Sales increased 40% from Q1 to Q2">

<!-- Decorative image: Empty alt -->
<img src="decorative-line.png" alt="">

<!-- Complex image: Use aria-describedby -->
<img src="diagram.png" alt="System architecture" aria-describedby="diagram-desc">
<p id="diagram-desc">The diagram shows three layers: frontend, API, and database...</p>
```

## Color and Contrast

- **Normal text**: 4.5:1 contrast ratio minimum
- **Large text** (18px+ or 14px+ bold): 3:1 minimum
- **UI components**: 3:1 for interactive elements
- Never use color alone to convey meaning (add icons, patterns, text)

Tools: WebAIM Contrast Checker, Chrome DevTools Accessibility panel

## Keyboard Accessibility

Use `:focus-visible` to show focus rings for keyboard users while hiding them for mouse users. Provide a visible `outline` with sufficient contrast on `:focus`, then suppress it on `:focus:not(:focus-visible)`.

### Requirements
- All interactive elements reachable via Tab
- Focus order follows visual order
- Focus indicator always visible
- Escape closes modals/dropdowns
- Arrow keys for widget navigation
- Enter/Space activates buttons

## Forms

```html
<form>
  <label for="email">Email address</label>
  <input type="email" id="email" aria-describedby="email-hint email-error" required>
  <p id="email-hint">We'll never share your email.</p>
  <p id="email-error" role="alert" hidden>Please enter a valid email.</p>
</form>
```

### Requirements
- Every input has an associated `<label>` (via `for`/`id` or wrapping)
- Error messages linked via `aria-describedby`
- Required fields indicated visually AND programmatically
- Clear error identification and recovery instructions

## ARIA (Use Sparingly)

First rule of ARIA: Don't use ARIA if native HTML works.

For full widget implementations (tabs, dialogs, menus, comboboxes, tooltips), see `aria-patterns.md`.

### Common ARIA Attributes
- `aria-label`: Label when no visible text exists
- `aria-labelledby`: Reference visible label element
- `aria-describedby`: Reference description/hint text
- `aria-live="polite"`: Announce dynamic content changes
- `aria-expanded`: Toggle state for expandable sections
- `aria-hidden="true"`: Hide decorative elements from AT

## Dynamic Content

Use `aria-live` regions to announce content changes to screen readers. For toast/alert patterns, see `aria-patterns.md`.

```html
<!-- Container must exist in DOM before content is injected -->
<div aria-live="polite" aria-atomic="true">
  <!-- Updated dynamically via JS -->
</div>
```

## Mobile Accessibility

- Touch targets minimum 44x44 CSS pixels (see `compliance-frameworks/wcag` for AA minimums)
- Labels announce tap actions
- Swipe and drag gestures have single-pointer alternatives
- Text scales with user font size settings

## Testing

Automated tests catch ~30% of issues. Always combine with keyboard and screen reader testing.
For a full testing strategy breakdown, see `compliance-frameworks/wcag`.

- **Automated scanning**: Integrate axe-core (or similar) into your test suite — check their docs for current API
- **Keyboard testing**: Navigate the full interface with Tab, Enter, Escape, arrow keys
- **Screen reader testing**: VoiceOver (macOS/iOS), NVDA (Windows), TalkBack (Android)

## Avoid

- **Div/span for buttons** — Use `<button>` or `<a href>`; divs aren't focusable or announced
- **Removing focus outlines without replacement** — Always provide visible focus indicator
- **Color-only information** — Add text, icons, or patterns alongside color
- **Auto-playing media** — Provide pause controls; avoid autoplay
- **Positive `tabindex` values** — Use `0` or `-1` only; positive values break natural order
- **Mouse-only interactions** — Hover effects need keyboard/focus equivalents

For ARIA-specific mistakes (redundant roles, `aria-hidden` on focusable elements, etc.), see `aria-patterns.md` > Common Mistakes.
