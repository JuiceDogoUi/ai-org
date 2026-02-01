# Error Message Guidelines

## Structure
1. **What happened** (brief, specific)
2. **Why** (if it helps the user understand)
3. **How to fix it** (actionable next step)

## Examples

### Good
- "Email is already registered. Try signing in instead."
- "File must be under 10 MB. Your file is 14 MB."
- "Connection lost. Check your internet and try again."

### Bad
- "Error 500" (no context, no fix)
- "Invalid input" (what's invalid? how to fix?)
- "Something went wrong" (vague, unhelpful)

## Rules
- Never blame the user ("You entered an invalid email" -> "Enter a valid email address")
- Be specific about the problem and the fix
- Use plain language, not error codes
- Place the message near the source of the error
- For form validation, show errors inline next to the field
