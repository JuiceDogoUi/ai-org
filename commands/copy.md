---
name: copy
description: Write copy grounded in your brand voice and positioning
argument-hint: "[type: landing|email|ux|social] [context]"
user-invocable: true
context: fork
model: sonnet
---

# Copy: $ARGUMENTS

You are Claude Code coordinating copy creation.

## How to Spawn Agents

Use the Task tool. Spawn each agent by name (e.g., `writer-lead`).

**If an agent doesn't exist:** Handle that task directly using the same approach.

---

## Step 1: Gather Brand Context

**You (Claude Code):** Before spawning any agent, find existing brand material:

1. **Positioning** — check `strategy/foundation/positioning.md`, `strategy/positioning.md`,
   or any positioning document. Extract: target audience, competitive alternatives,
   unique value, key differentiators.

2. **Personas** — check `strategy/foundation/personas.md` or similar.
   Extract: who we're writing for, their pain points, language they use.

3. **Voice & tone** — check CLAUDE.md, style guides, or existing copy for:
   - Formal vs conversational
   - Technical vs accessible
   - Brand-specific terms or phrases to use/avoid

4. **Existing copy patterns** — check targeted locations for similar copy:
   - UI strings: component files, i18n/locale files, constants
   - Marketing: `content/`, `marketing/`, `copy/`, landing page templates, README
   - Note the tone, structure, and length conventions from what you find

5. **Detect copy type** from $ARGUMENTS:
   - `landing` → long-form persuasive, hero/features/CTA structure
   - `email` → subject line + body, clear CTA
   - `ux` → microcopy: buttons, tooltips, error messages, empty states
   - `social` → platform-aware (character limits, hashtags, hooks)
   - If not specified → infer from context or ask user

---

## Step 2: Write

**Spawn: writer-lead** with:
- Copy type and context from $ARGUMENTS
- Positioning summary (target, value prop, differentiators)
- Persona details (audience, pain points, language)
- Voice & tone guidelines found
- Examples of existing copy for consistency
- If UX copy: include the UI context (what screen, what action, what state)

---

## Step 3: Review

**You (Claude Code):** After the agent finishes:

1. **Tone consistency** — does the copy match the voice found in Step 1?
2. **Placeholder check** — scan for `[brackets]`, `Lorem ipsum`, `TODO`, `TBD`,
   or generic filler that shouldn't ship
3. **Audience fit** — does the language match the persona's vocabulary level?
4. **CTA clarity** — for landing pages and emails, verify a clear next action exists

Flag any issues found. If clean, summarize:

```
## Copy: {type}

- **Audience:** {persona or target}
- **Voice:** {tone detected/applied}
- **Deliverables:** {what was created}
- **Brand alignment:** {matched/adjusted}
```
