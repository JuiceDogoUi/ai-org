# ARIA Widget Patterns

Common accessible widget implementations following WAI-ARIA Authoring Practices.

## Tabs

```html
<div role="tablist" aria-label="Account settings">
  <button role="tab" id="tab-1" aria-selected="true" aria-controls="panel-1">
    Profile
  </button>
  <button role="tab" id="tab-2" aria-selected="false" aria-controls="panel-2" tabindex="-1">
    Security
  </button>
</div>

<div role="tabpanel" id="panel-1" aria-labelledby="tab-1">
  <!-- Profile content -->
</div>
<div role="tabpanel" id="panel-2" aria-labelledby="tab-2" hidden>
  <!-- Security content -->
</div>
```

**Keyboard**: Arrow keys move between tabs, Tab moves into panel, Home/End for first/last tab.

## Modal Dialog

Prefer the native `<dialog>` element — it handles focus trapping, Escape to close, and background scroll prevention automatically.

```html
<dialog id="confirm-dialog" aria-labelledby="dialog-title">
  <h2 id="dialog-title">Confirm deletion</h2>
  <p>Are you sure you want to delete this item?</p>
  <button value="cancel">Cancel</button>
  <button value="confirm">Delete</button>
</dialog>
```

```javascript
// Open: focus moves into dialog automatically
document.getElementById('confirm-dialog').showModal();

// Close: focus returns to the trigger element automatically
document.getElementById('confirm-dialog').close();
```

**What `<dialog>` gives you for free**: focus trapping, Escape key close, background inert, focus restoration on close.

**Still required**:
- Set `aria-labelledby` to reference the dialog heading
- Style the `::backdrop` for visual contrast
- Handle the `close` event for cleanup logic

## Disclosure (Accordion)

```html
<h3>
  <button aria-expanded="false" aria-controls="section-1">
    Shipping details
  </button>
</h3>
<div id="section-1" hidden>
  <!-- Content -->
</div>
```

**Keyboard**: Enter/Space toggles expanded state.

## Combobox (Autocomplete)

```html
<label for="search">Search cities</label>
<input id="search" role="combobox"
       aria-expanded="false"
       aria-autocomplete="list"
       aria-controls="results"
       aria-activedescendant="">

<ul id="results" role="listbox" hidden>
  <li id="opt-1" role="option">New York</li>
  <li id="opt-2" role="option">New Orleans</li>
</ul>
```

**Keyboard**: Down arrow opens list and moves through options, Enter selects, Escape closes.

Update `aria-expanded` when list opens/closes. Update `aria-activedescendant` to the focused option's ID.

## Menu

```html
<button aria-haspopup="true" aria-expanded="false" aria-controls="menu-1">
  Actions
</button>
<ul id="menu-1" role="menu" hidden>
  <li role="menuitem">Edit</li>
  <li role="menuitem">Duplicate</li>
  <li role="separator"></li>
  <li role="menuitem">Delete</li>
</ul>
```

**Keyboard**: Enter/Space/Down opens menu, Arrow keys navigate items, Escape closes, Home/End for first/last item.

## Toast / Alert

```html
<!-- role="status" implies aria-live="polite" — announced after current speech -->
<div role="status">
  Settings saved successfully.
</div>

<!-- role="alert" implies aria-live="assertive" — interrupts current speech (use sparingly) -->
<div role="alert">
  Error: Payment failed. Please try again.
</div>
```

**Rules**:
- The live region container must exist in DOM before content is added
- Use `role="status"` for success messages, `role="alert"` for errors
- Don't add explicit `aria-live` when the role already implies it
- Don't overuse -- too many announcements overwhelm screen reader users

## Tooltip

```html
<button aria-describedby="tip-1">
  <svg aria-hidden="true"><!-- icon --></svg>
  Settings
</button>
<div id="tip-1" role="tooltip" hidden>
  Configure application preferences
</div>
```

**Requirements**: Show on hover and focus, hide on Escape, dismiss when pointer leaves.

## Common Mistakes to Avoid

1. **Adding `role` to elements that already have it** -- `<button role="button">` is redundant
2. **Using `aria-label` on non-interactive elements** -- screen readers may ignore it on `div`/`span`
3. **Hiding content with `display: none` that should be announced** -- use `aria-live` regions
4. **Forgetting `aria-current="page"`** on active navigation links
5. **Using `aria-hidden="true"` on focusable elements** -- creates a confusing ghost element
