# Accessibility Checklist

## Keyboard
- [ ] All interactive elements reachable via Tab
- [ ] Focus order follows visual layout
- [ ] Focus indicator is visible (never `outline: none` without alternative)
- [ ] Escape closes modals/dropdowns
- [ ] Enter/Space activates buttons and links
- [ ] Arrow keys navigate within composite widgets (tabs, menus, listboxes)

## Images & Media
- [ ] Informative images have descriptive alt text
- [ ] Decorative images have empty alt (`alt=""`)
- [ ] Videos have captions
- [ ] Audio has transcripts

## Forms
- [ ] Every input has an associated label
- [ ] Required fields are indicated (not by color alone)
- [ ] Error messages identify the field and describe the error
- [ ] Form groups use fieldset/legend

## Color & Contrast
- [ ] Text contrast ratio meets 4.5:1 (normal) / 3:1 (large)
- [ ] Information not conveyed by color alone
- [ ] UI components have 3:1 contrast against background

## Structure
- [ ] One `h1` per page, headings in logical order
- [ ] Landmarks used (`main`, `nav`, `aside`, `footer`)
- [ ] Skip link provided for keyboard users
- [ ] Language attribute set on `html` element

## Dynamic Content
- [ ] Loading states announced to screen readers
- [ ] Route changes announce new page title
- [ ] Modals trap focus and restore on close
- [ ] Notifications use `aria-live` regions
