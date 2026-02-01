# Translation Workflow

## Process Overview

```text
Developer writes code     →  Extract strings  →  Send to translators
     with i18n markers         (CI/tooling)        (TMS or files)
                                                         │
Deploy localized build   ←  Import translations  ←  Review & approve
     (per locale)              (CI/tooling)          (QA + native speakers)
```

## File Formats

| Format | Used By | Pros | Cons |
|--------|---------|------|------|
| XLIFF (.xlf) | Angular, many TMS | Industry standard, rich metadata | Verbose XML |
| JSON (flat) | React, Node.js | Simple, easy to diff | No built-in metadata |
| JSON (nested) | i18next, react-intl | Organized by namespace | Harder to search |
| .properties | Java/Spring | Simple key=value | No nesting, limited encoding |
| .xcstrings | Swift/iOS | Xcode-native, plural support | Apple ecosystem only |
| .po/.pot | gettext | Mature tooling, comments | Legacy format |

## Directory Structure

### Flat (simple projects)
```text
src/locale/
├── en.json          # Source language
├── fr.json
├── de.json
└── ar.json
```

### Namespaced (large projects)
```text
src/locale/
├── en/
│   ├── common.json      # Shared strings (nav, footer, errors)
│   ├── auth.json        # Login, registration
│   ├── checkout.json    # Cart, payment, shipping
│   └── dashboard.json   # Dashboard-specific
├── fr/
│   ├── common.json
│   ├── auth.json
│   ├── checkout.json
│   └── dashboard.json
```

## Translation Management

### Key Naming Conventions
```json
{
  "auth.login.title": "Sign in to your account",
  "auth.login.email.label": "Email address",
  "auth.login.email.placeholder": "you@example.com",
  "auth.login.email.error.required": "Email is required",
  "auth.login.email.error.invalid": "Enter a valid email address",
  "auth.login.submit": "Sign in",
  "auth.login.forgot": "Forgot your password?"
}
```

Pattern: `feature.screen.element.state`

### Context for Translators
```json
{
  "order.status.draft": {
    "value": "Draft",
    "description": "Order status label when order has not been submitted yet"
  },
  "nav.draft": {
    "value": "Drafts",
    "description": "Navigation menu item linking to the drafts list page"
  }
}
```

Same English word, different context = different translation in many languages.

### Handling Plurals (ICU MessageFormat)
```json
{
  "cart.items": "{count, plural, =0 {Your cart is empty} one {1 item in your cart} other {{count} items in your cart}}",
  "notifications.unread": "{count, plural, =0 {No new notifications} one {1 unread notification} other {{count} unread notifications}}"
}
```

Languages like Arabic have 6 plural forms. Always use ICU — never `if count === 1`.

## CI Integration

### Extract on Every PR
```yaml
# GitHub Actions example
i18n-check:
  runs-on: ubuntu-latest
  steps:
    - uses: actions/checkout@v4
    - run: npm ci
    - run: npx ng extract-i18n --output-path src/locale
    - run: |
        if git diff --name-only | grep -q 'locale/'; then
          echo "::warning::New translatable strings detected. Update translation files."
        fi
```

### Missing Translation Detection
```bash
# Compare source keys against each locale
SOURCE_KEYS=$(jq -r 'keys[]' src/locale/en.json | sort)
for locale in fr de ar; do
  LOCALE_KEYS=$(jq -r 'keys[]' "src/locale/${locale}.json" | sort)
  MISSING=$(comm -23 <(echo "$SOURCE_KEYS") <(echo "$LOCALE_KEYS"))
  if [ -n "$MISSING" ]; then
    echo "Missing keys in ${locale}: ${MISSING}"
  fi
done
```

## Quality Checks

- **Length**: Flag translations >50% longer than source (may break UI)
- **Variables**: Verify all `{placeholders}` from source exist in translation
- **Punctuation**: Check trailing periods, colons, question marks match
- **Capitalization**: Some languages don't capitalize titles the same way
- **Screenshots**: Include UI screenshots for translators to see context
- **Pseudo-localization**: Replace strings with accented versions (ÀççéñţéÐ) to catch hardcoded text and layout issues before real translation
