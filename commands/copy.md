---
name: copy
description: Write marketing or UX copy
argument-hint: "[type: landing|email|ux|social] [context]"
context: fork
agent: orchestrator
---

Write copy: $ARGUMENTS

## Routing

- Landing page, email, social media → writer-marketing agent
- UX microcopy, in-app text, error messages → writer-ux agent
- Mixed or unclear → coordinate both agents

## Standards

- Match the brand's existing voice and tone
- Be concise and action-oriented
- Focus on benefits, not features (for marketing)
- Be clear and helpful (for UX copy)
