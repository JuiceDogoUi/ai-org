---
name: copywrite
description: Write marketing or UX copy
argument-hint: "[type: landing|email|ux|social] [context]"
context: fork
agent: orchestrator
---

Write copy: $ARGUMENTS

If strategy/foundation/positioning.md exists, read it first and align copy with positioning.

## Routing

- Landing page, email, social media → writer-marketing agent
- UX microcopy, in-app text, error messages → writer-ux agent
- Mixed or unclear → coordinate both agents

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
