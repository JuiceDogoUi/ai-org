# WCAG Quick Reference

The Web Content Accessibility Guidelines (WCAG) are published by the W3C Web Accessibility Initiative. Most regulations reference WCAG 2.1 AA as the minimum standard, though WCAG 2.2 is the current version.

**Official sources**: w3.org/WAI/WCAG22 (specification), w3.org/WAI/WCAG22/quickref (customizable quick reference), w3.org/WAI/WCAG22/Understanding (understanding docs)

## Structure

WCAG is organized into 4 principles, each with guidelines, each with testable success criteria at 3 conformance levels:

| Principle | Guidelines | Key concern |
|-----------|-----------|-------------|
| **Perceivable** | Text alternatives, time-based media, adaptable, distinguishable | Can users perceive the content? |
| **Operable** | Keyboard accessible, enough time, seizures, navigable, input modalities | Can users operate the interface? |
| **Understandable** | Readable, predictable, input assistance | Can users understand the content and interface? |
| **Robust** | Compatible with assistive technologies | Does it work with screen readers, etc.? |

## Most Commonly Failed AA Success Criteria

These are the criteria most frequently violated in codebase audits. Always check the full criteria list for your target conformance level.

| SC | Name | Common failure |
|----|------|---------------|
| 1.1.1 | Non-text Content | Missing alt text on images |
| 1.3.1 | Info and Relationships | Using visual styling instead of semantic HTML |
| 1.4.3 | Contrast (Minimum) | Text color too close to background color |
| 1.4.11 | Non-text Contrast | UI component boundaries not visible enough |
| 2.1.1 | Keyboard | Interactive elements not reachable via keyboard |
| 2.4.3 | Focus Order | Tab order doesn't match visual layout |
| 2.4.7 | Focus Visible | No visible focus indicator |
| 2.5.8 | Target Size (Minimum) | Touch targets smaller than 24×24 CSS pixels (WCAG 2.2) |
| 3.3.2 | Labels or Instructions | Form fields without associated labels |
| 4.1.2 | Name, Role, Value | Custom components missing ARIA attributes |

## Testing Approach

No single method catches all issues. Use a layered approach:

1. **Automated scanning** (~30% of issues): axe-core, Lighthouse, WAVE, pa11y
2. **Keyboard testing** (~20% of issues): navigate the entire interface without a mouse
3. **Screen reader testing** (~20% of issues): VoiceOver (macOS/iOS), NVDA (Windows), TalkBack (Android)
4. **Manual review** (~30% of issues): check against each applicable success criterion
5. **User testing with people with disabilities**: the most reliable but most resource-intensive

## What Changed in WCAG 2.2

WCAG 2.2 added 9 new success criteria over 2.1. Key additions:
- **2.4.11 Focus Not Obscured (Minimum)** (AA) — focused element not fully hidden
- **2.4.13 Focus Appearance** (AAA) — minimum focus indicator size and contrast
- **2.5.7 Dragging Movements** (AA) — alternatives to drag-and-drop
- **2.5.8 Target Size (Minimum)** (AA) — 24×24 CSS pixels minimum
- **3.2.6 Consistent Help** (A) — help mechanisms in consistent location
- **3.3.7 Redundant Entry** (A) — don't ask for same info twice
- **3.3.8 Accessible Authentication (Minimum)** (AA) — no cognitive function tests for auth

Research the full list from the official specification for the version your applicable regulations reference.
