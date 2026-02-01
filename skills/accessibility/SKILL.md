---
name: accessibility
description: WCAG compliance, ARIA patterns, and accessibility best practices. Use when implementing or reviewing UI for accessibility.
user-invocable: false
---

# Accessibility (a11y)

## WCAG 2.1 Principles
1. **Perceivable**: Content available to all senses (alt text, captions, contrast)
2. **Operable**: All functionality via keyboard, sufficient time, no seizure triggers
3. **Understandable**: Readable, predictable, input assistance
4. **Robust**: Compatible with assistive technologies

## Essential Practices
- Use semantic HTML (`button`, `nav`, `main`, `h1-h6`) over `div`/`span`
- All images need `alt` text (empty `alt=""` for decorative images)
- Color contrast: 4.5:1 for normal text, 3:1 for large text
- All interactive elements must be keyboard accessible
- Focus must be visible and follow a logical order
- Forms need associated labels (`for`/`id` or wrapping `label`)
- Error messages must be associated with their fields (`aria-describedby`)

## ARIA (Use Sparingly)
- First rule: don't use ARIA if native HTML works
- `role` for custom widgets (e.g., `role="tablist"`)
- `aria-label` for elements without visible text
- `aria-live="polite"` for dynamic content updates
- `aria-expanded`, `aria-selected` for interactive widgets

For full checklist, see [checklist.md](checklist.md).
For ARIA widget patterns, see [aria-patterns.md](aria-patterns.md).
