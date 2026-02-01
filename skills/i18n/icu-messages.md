# ICU MessageFormat Patterns

ICU MessageFormat is the standard for handling plurals, gender, and dynamic content
in translated strings. Supported by Angular, react-intl, Java MessageFormat, and most
translation management systems.

## Basic Interpolation
```text
Hello, {name}!
You have {count} notifications.
```

## Plural
```text
{count, plural,
  =0 {No messages}
  one {1 message}
  other {{count} messages}
}
```

### Plural Categories by Language
| Language | Categories |
|----------|-----------|
| English | one, other |
| French | one, other (0 is "one") |
| Arabic | zero, one, two, few, many, other |
| Polish | one, few, many, other |
| Japanese | other (no plural) |
| Russian | one, few, many, other |

Always define at least `one` and `other`. Add `=0` for explicit zero handling.
Use CLDR plural rules as reference: https://cldr.unicode.org/index/cldr-spec/plural-rules

## Select (enum/category)
```text
{role, select,
  admin {Administrator access granted}
  editor {Editor access granted}
  other {Viewer access granted}
}
```

`other` is required as fallback.

## Gender / Selectordinal
```text
{gender, select,
  female {She completed her profile}
  male {He completed his profile}
  other {They completed their profile}
}

{position, selectordinal,
  one {#st place}
  two {#nd place}
  few {#rd place}
  other {#th place}
}
```

## Nested (plural inside select)
```text
{gender, select,
  female {{count, plural,
    one {She has 1 item}
    other {She has {count} items}
  }}
  male {{count, plural,
    one {He has 1 item}
    other {He has {count} items}
  }}
  other {{count, plural,
    one {They have 1 item}
    other {They have {count} items}
  }}
}
```

## Number and Date Formatting
```text
Price: {price, number, currency}
Date: {date, date, medium}
Percent: {ratio, number, percent}
```

## Common Mistakes

### 1. Concatenating strings
```text
// BAD -- word order differs across languages
"Welcome to " + appName + "!"

// GOOD
"Welcome to {appName}!"
```

### 2. Conditional logic instead of ICU
```text
// BAD
count === 1 ? "1 item" : count + " items"

// GOOD
"{count, plural, one {1 item} other {{count} items}}"
```

### 3. Reusing strings across contexts
```text
// BAD -- "Open" as verb and adjective translate differently
{ "open": "Open" }  // used for both "Open file" button and "Status: Open"

// GOOD
{ "action.open": "Open", "status.open": "Open" }
```

### 4. Hardcoding date/number formats
```text
// BAD
`${month}/${day}/${year}`   // US-only

// GOOD
new Intl.DateTimeFormat(locale, { dateStyle: 'medium' }).format(date)
```

### 5. Embedding HTML in translations
```text
// BAD -- translators see HTML tags, easy to break
"Click <a href='/help'>here</a> for help"

// ACCEPTABLE -- use named placeholders
"Click {linkStart}here{linkEnd} for help"

// BEST -- restructure to avoid inline links
"Need help? {helpLink}"
```

## Angular ICU Examples
```html
<!-- Plural -->
<span i18n>
  {unread, plural,
    =0 {No unread messages}
    =1 {1 unread message}
    other {{{unread}} unread messages}
  }
</span>

<!-- Select -->
<span i18n>
  {status, select,
    active {Account is active}
    suspended {Account is suspended}
    other {Account status unknown}
  }
</span>

<!-- Nested -->
<span i18n>
  {gender, select,
    female {{count, plural, =1 {She liked 1 post} other {She liked {{count}} posts}}}
    male {{count, plural, =1 {He liked 1 post} other {He liked {{count}} posts}}}
    other {{count, plural, =1 {They liked 1 post} other {They liked {{count}} posts}}}
  }
</span>
```
