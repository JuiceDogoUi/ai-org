---
name: accessibility
description: WCAG compliance, ARIA patterns, and accessibility best practices. Use when implementing or reviewing UI for accessibility.
user-invocable: false
---

# Accessibility (a11y)

## WCAG 2.2 Principles

1. **Perceivable**: Content available to all senses (alt text, captions, contrast)
2. **Operable**: All functionality via keyboard, sufficient time, no seizure triggers
3. **Understandable**: Readable, predictable, input assistance
4. **Robust**: Compatible with assistive technologies

### New in WCAG 2.2

- **Focus Not Obscured (2.4.11)** — Focused element not fully hidden by other content
- **Focus Appearance (2.4.13)** — Focus indicator has sufficient area and contrast
- **Dragging Movements (2.5.7)** — Single pointer alternative for drag operations
- **Target Size Minimum (2.5.8)** — Interactive targets at least 24x24 CSS pixels
- **Consistent Help (3.2.6)** — Help mechanisms in consistent location across pages
- **Redundant Entry (3.3.7)** — Don't require re-entering previously submitted info
- **Accessible Authentication (3.3.8)** — No cognitive function tests (puzzles, memorization)

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

```html
<!-- Ensure focus visibility -->
<style>
  :focus {
    outline: 2px solid #005fcc;
    outline-offset: 2px;
  }
  /* Only hide outline for mouse users */
  :focus:not(:focus-visible) {
    outline: none;
  }
</style>
```

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

```html
<!-- Custom tab panel -->
<div role="tablist" aria-label="Settings tabs">
  <button role="tab" aria-selected="true" aria-controls="panel-1" id="tab-1">General</button>
  <button role="tab" aria-selected="false" aria-controls="panel-2" id="tab-2">Security</button>
</div>
<div role="tabpanel" id="panel-1" aria-labelledby="tab-1">...</div>
<div role="tabpanel" id="panel-2" aria-labelledby="tab-2" hidden>...</div>
```

### Common ARIA Attributes
- `aria-label`: Label when no visible text exists
- `aria-labelledby`: Reference visible label element
- `aria-describedby`: Reference description/hint text
- `aria-live="polite"`: Announce dynamic content changes
- `aria-expanded`: Toggle state for expandable sections
- `aria-hidden="true"`: Hide decorative elements from AT

## Dynamic Content

```javascript
// Announce updates to screen readers
<div aria-live="polite" aria-atomic="true">
  {statusMessage}
</div>

// Manage focus for modals
function openModal() {
  modal.showModal(); // <dialog> handles focus automatically
}
```

## Mobile Accessibility

- Touch targets minimum 44x44 CSS pixels (WCAG 2.2: 24x24 minimum for Level AA)
- Labels announce tap actions
- Swipe gestures have button alternatives (WCAG 2.2 Dragging Movements)
- Text scales with user font size settings

## Testing

### Manual Testing
- Navigate with keyboard only (Tab, Enter, Escape, arrows)
- Test with screen reader (VoiceOver, NVDA, JAWS)
- Zoom to 200%, verify layout doesn't break
- Disable CSS, verify content order makes sense

### Automated Testing
```javascript
// axe-core integration
import { axe } from 'jest-axe';

test('has no accessibility violations', async () => {
  const { container } = render(<MyComponent />);
  const results = await axe(container);
  expect(results).toHaveNoViolations();
});
```

## Avoid

- **Div/span for buttons** — Use `<button>` or `<a href>`; divs aren't focusable or announced
- **Removing focus outlines without replacement** — Always provide visible focus indicator
- **Color-only information** — Add text, icons, or patterns alongside color
- **Auto-playing media** — Provide pause controls; avoid autoplay
- **Positive `tabindex` values** — Use `0` or `-1` only; positive values break natural order
- **ARIA roles on wrong elements** — `role="button"` on a div still needs keyboard handling
- **Missing alt text** — Every `<img>` needs `alt`; empty for decorative
- **Inaccessible custom widgets** — Use native elements or follow ARIA Authoring Practices
- **Relying solely on automated tests** — Automated tests catch ~30% of issues; manual testing required
- **Mouse-only interactions** — Hover effects need keyboard/focus equivalents
