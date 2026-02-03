---
name: copywrite
description: Write marketing or UX copy
argument-hint: "[type: landing|email|ux|social] [context]"
context: fork
agent: writer-lead
---

Write copy: $ARGUMENTS

If strategy/foundation/positioning.md exists, read it first and align copy with positioning.

## Routing

All copy tasks route to **writer-lead**, which adapts its approach based on copy type:
- Landing pages, emails, social media → marketing copy approach
- UX microcopy, in-app text, error messages → UX writing approach

## Standards

- Match the brand's existing voice and tone
- Be concise and action-oriented
- Focus on benefits, not features (for marketing)
- Be clear and helpful (for UX copy)

## Output

- Marketing copy: full draft in markdown with headline, subheadline, body, CTA
- UX copy: structured list of strings with context (where each string appears, character limits if applicable)
- Include 2-3 alternatives for headlines/CTAs when appropriate

> Related: `/article` for long-form content, `/position` to define positioning before writing copy.
