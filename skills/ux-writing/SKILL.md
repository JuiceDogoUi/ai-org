---
name: ux-writing
description: Microcopy principles, UI text patterns, error messages, and in-app guidance. Use when writing interface text, button labels, error messages, or onboarding copy.
user-invocable: false
---

# UX Writing

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

### Structure
1. **What happened** — Clear, specific description
2. **Why** — Context if helpful (optional)
3. **How to fix** — Actionable next step

### Examples
- Bad: "Error 500"
- Good: "We couldn't save your changes. Please try again."

- Bad: "Invalid input"
- Good: "Enter a valid email address (e.g., name@company.com)"

### Tone
- No blame: "Please enter a valid email" not "You entered an invalid email"
- No jargon: "Something went wrong" not "Exception in thread main"
- Specific: "File must be under 10MB" not "File too large"

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

- Confirm what will happen before destructive actions
- Use specific language: "Delete 'Project Alpha'? This cannot be undone."
- Match button text to action: "Delete project" not "OK"

## Onboarding

- One concept per step
- Show progress (step 2 of 4)
- Let users skip and return later
- Celebrate completion

## Success Messages

- Confirm the action completed: "Project created"
- Suggest next step if relevant: "Project created. Invite your team to get started."
- Don't over-celebrate routine actions

## Tooltips & Help Text

- Keep under 150 characters
- Answer "what is this?" or "why should I care?"
- Use for non-obvious features, not obvious ones
- Link to docs for complex topics

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
