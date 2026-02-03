---
name: i18n
description: Internationalization and localization patterns — string extraction, locale management, pluralization, RTL support, date/number formatting. Use when building or reviewing multi-language support.
user-invocable: false
---

# Internationalization (i18n) & Localization (l10n)

## Core Principles

1. **Externalize all user-facing strings** — no hardcoded text in templates or code
2. **Use ICU MessageFormat** for pluralization and gender
3. **Never concatenate strings** — word order varies across languages
4. **Design for expansion** — translations are typically 30-40% longer than English
5. **Separate translation from code** — translators work on resource files, not source code

## String Management

### Key Naming
```json
{
  "checkout.shipping.label": "Shipping address",
  "checkout.shipping.placeholder": "Enter your address",
  "checkout.submit": "Complete order",
  "errors.required": "{field} is required"
}
```

- Use meaningful, hierarchical keys
- Group by feature/page, not component
- Include translator context in comments
- Never reuse strings across different contexts

### Extraction
```javascript
// Bad: Hardcoded strings
<button>Submit</button>

// Good: Externalized
<button>{t('form.submit')}</button>

// Good: With context for translators
<button>{t('form.submit', { context: 'Button to submit contact form' })}</button>
```

## ICU MessageFormat

### Pluralization
```
{count, plural,
  =0 {No items in cart}
  one {# item in cart}
  other {# items in cart}
}
```

### Select (Gender/Category)
```
{gender, select,
  female {She liked your post}
  male {He liked your post}
  other {They liked your post}
}
```

### Combined
```
{name} has {count, plural,
  =0 {no new messages}
  one {# new message}
  other {# new messages}
}
```

## Date/Time Formatting

```javascript
// Use Intl APIs, never manual formatting
const date = new Date();

// Locale-aware date
new Intl.DateTimeFormat('de-DE', {
  year: 'numeric',
  month: 'long',
  day: 'numeric'
}).format(date); // "15. Januar 2024"

// Relative time
new Intl.RelativeTimeFormat('en', { numeric: 'auto' })
  .format(-1, 'day'); // "yesterday"
```

## Number/Currency Formatting

```javascript
// Numbers
new Intl.NumberFormat('de-DE').format(1234.56); // "1.234,56"

// Currency
new Intl.NumberFormat('en-US', {
  style: 'currency',
  currency: 'USD'
}).format(99.99); // "$99.99"

// Percentage
new Intl.NumberFormat('en', {
  style: 'percent',
  minimumFractionDigits: 1
}).format(0.156); // "15.6%"
```

## RTL Support

```css
/* Use logical properties */
.sidebar {
  /* Bad: Physical properties */
  margin-left: 20px;
  padding-right: 10px;

  /* Good: Logical properties */
  margin-inline-start: 20px;
  padding-inline-end: 10px;
}

/* Logical equivalents */
/* left → inline-start */
/* right → inline-end */
/* top → block-start */
/* bottom → block-end */
```

```html
<!-- Set document direction -->
<html lang="ar" dir="rtl">
```

### RTL Guidelines
- Mirror layouts (except universal icons: play, search, share)
- Test with actual RTL text, not just CSS direction
- Bidirectional text needs proper isolation
- Numbers and phone numbers stay LTR within RTL context

## Framework Integration

### React (react-i18next)
```javascript
import { useTranslation, Trans } from 'react-i18next';

function Component() {
  const { t } = useTranslation();

  return (
    <>
      <h1>{t('welcome.title')}</h1>
      <Trans i18nKey="welcome.description">
        Welcome, <strong>{{name}}</strong>!
      </Trans>
    </>
  );
}
```

### Angular (@angular/localize)
```typescript
// Component
import { $localize } from '@angular/localize';

const message = $localize`:@@welcome.title:Welcome to our app`;

// Template
<h1 i18n="@@welcome.title">Welcome to our app</h1>
```

### Vue (vue-i18n)
```vue
<template>
  <h1>{{ $t('welcome.title') }}</h1>
  <p>{{ $t('items.count', { count: items.length }) }}</p>
</template>
```

## Translation Workflow

1. **Develop** with source strings in code
2. **Extract** strings to resource files (JSON, XLIFF)
3. **Translate** via TMS (Crowdin, Lokalise, Phrase)
4. **Review** translations in context
5. **Deploy** with bundled or lazy-loaded translations

## Testing

```javascript
// Test with pseudo-localization
// "Submit" → "[Ṣṵḅṃḭṭ]" (accented, bracketed)

// Test expansion
// Pad strings by 30-40% to simulate German/Finnish

// Test RTL
// Switch to Arabic/Hebrew and verify layout
```

## Avoid

- **String concatenation** — `"Hello " + name` breaks in languages with different word order
- **Hardcoded date/number formats** — Use `Intl` APIs; never format manually
- **Assuming English text length** — Allow 30-40% expansion in UI design
- **Gendered language without variant** — Use neutral or provide gender options
- **Embedded HTML in strings** — Use ICU tags or framework-specific solutions
- **Reusing strings across contexts** — Same English word may need different translations
- **`left`/`right` CSS properties** — Use `inline-start`/`inline-end` for RTL support
- **Hardcoded locale** — Detect from browser, allow user override, persist preference
- **Untested translations** — Always review translations in context, not just files
- **Ignoring pluralization rules** — Some languages have 6+ plural forms; use ICU format
