---
name: i18n
description: Internationalization and localization patterns — string extraction, locale management, pluralization, RTL support, date/number formatting. Use when building or reviewing multi-language support.
user-invocable: false
---

# Internationalization (i18n) & Localization (l10n)

## Core Principles
1. **Externalize all user-facing strings** -- no hardcoded text in templates or code
2. **Use ICU MessageFormat** for pluralization and gender (`{count, plural, one {# item} other {# items}}`)
3. **Never concatenate strings** -- word order varies across languages
4. **Design for expansion** -- translations are typically 30-40% longer than English
5. **Separate translation from code** -- translators work on resource files, not source code

## String Management
- One canonical source of truth for strings (e.g., `en.json` or `.xlf`)
- Use meaningful keys: `checkout.shipping.label` not `str_42`
- Group keys by feature or page, not by component
- Include context/description for translators (`// Button to confirm purchase`)
- Never reuse strings across different contexts (same English word may translate differently)

## Formatting
- **Dates**: Use `Intl.DateTimeFormat` or framework equivalents, never manual formatting
- **Numbers**: Use `Intl.NumberFormat` for decimals, currency, percentages
- **Currency**: Always pair amount with currency code, respect locale placement
- **Lists**: Use `Intl.ListFormat` for joining items ("A, B, and C" vs "A, B et C")

## RTL Support
- Use logical CSS properties (`inline-start`/`inline-end`) instead of `left`/`right`
- Set `dir="rtl"` and `lang` attribute on `<html>`
- Mirror layouts but not icons with universal meaning (play, search)
- Test with actual RTL text, not just `direction: rtl`

## Framework Integration
- **Angular**: `@angular/localize` with `$localize` tagged templates and `.xlf` files
- **React**: `react-intl` or `react-i18next` with JSON resource bundles
- **Swift/iOS**: `String(localized:)` with `.xcstrings` catalog
- **Java/Spring**: `MessageSource` with `messages_xx.properties` files
- **Node.js**: `i18next` with JSON namespace files

For Angular-specific patterns, see [angular-i18n.md](angular-i18n.md).
For general translation workflow, see [workflow.md](workflow.md).
For pluralization and ICU patterns, see [icu-messages.md](icu-messages.md).
