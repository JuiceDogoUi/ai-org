---
name: ux-writing
description: Microcopy principles, UI text patterns, error messages, and in-app guidance. Use when writing interface text, button labels, error messages, or onboarding copy.
user-invocable: false
---

# UX Writing

> **Documentation Freshness**: UX writing practices evolve with accessibility
> standards (WCAG), platform guidelines (Material Design, HIG), and inclusive
> language best practices. Check current platform guidelines for up-to-date conventions.

## File Guide
- **error-messages.md** — Error message structure, examples, and rules
- **patterns.md** — Confirmation dialogs, success messages, form labels, tooltip patterns

## Core Principles

- **Clear over clever** — Users are completing tasks, not reading for fun
- **Concise** — Use the fewest words that convey the meaning
- **Useful** — Every word helps the user act or understand state
- **Consistent** — Same action = same label everywhere in the product

## Button Labels

- Use verbs: "Save", "Delete", "Send" — not "OK" or "Submit"
- Be specific: "Save changes" > "Save", "Delete account" > "Delete"
- Match consequence to action: "Remove from cart" not "Delete"
- Destructive actions: Use specific language ("Delete project" not "Delete")

## Form Labels & Inputs

- Label above input, not inside (placeholder disappears)
- Use sentence case: "Email address" not "EMAIL ADDRESS"
- Mark optional fields, not required (most fields should be required)
- Inline validation with specific guidance: "Password must be 8+ characters"

## Error Messages

What happened → Why → How to fix. See **error-messages.md** for structure, examples, and rules.

## Empty States

- Explain what belongs here
- Show how to get started
- Include relevant action
- Example: "No projects yet. Create your first project to start building."

## Loading States

- Tell users what's happening: "Loading your dashboard..."
- For long operations: Show progress or steps
- For uncertain duration: Use indefinite progress with reassurance

## Confirmations

See **patterns.md** for confirmation dialog structure: title, consequence, action and cancel button text.

## Onboarding

- One concept per step
- Show progress (step 2 of 4)
- Let users skip and return later
- Celebrate completion

## Success Messages

Confirm the action, suggest a next step when relevant, and auto-dismiss for routine actions. See **patterns.md** for patterns and examples.

## Tooltips & Help Text

See **patterns.md** for tooltip patterns. Keep under 150 characters, explain what something does, and link to docs for complex topics.

## Capitalization

- **Sentence case** for most UI text (titles, buttons, labels)
- **Title Case** only for proper nouns and product names
- Avoid ALL CAPS except for rare emphasis

## Punctuation

- No periods on headings, buttons, or labels
- Periods on complete sentences (descriptions, help text)
- Use contractions naturally (don't, we'll) — matches speech

## Avoid

- **Jargon and technical terms** — Speak the user's language
- **Blame language** — "Invalid" sounds like user's fault
- **Vague messages** — "An error occurred" helps no one
- **Robotic tone** — Write like a helpful human
- **Double negatives** — "Don't forget to not skip" is confusing
- **Exclamation points** — Reserved for genuine celebration only
