# AI Organization Plugin

## Interaction Model
- Users invoke slash commands (e.g., /plan, /build, /review) for known workflows
- Claude Code acts as the workflow coordinator, spawning specialist agents via Task() at each stage
- Commands define explicit stages with Task() spawns — no separate orchestrator agent
- Agents invoke skills as domain references; skills are NOT absorbed into agent identity
- Each agent has scoped skills declared in its frontmatter

## Agent Model Tiers
- **Opus**: Complex reasoning, architecture, strategy, multi-stage workflows
- **Sonnet**: Standard engineering, review, product work
- **Haiku**: Fast lookup, code exploration, simple formatting, status checks

## Coordination Principle
Commands define explicit workflows. Simple commands spawn a single agent directly.
Complex commands (like /build, /feature, /review) define stages and spawn multiple agents.
Claude Code coordinates the workflow — there is no separate orchestrator agent.

## Skill Isolation
Skills are domain knowledge containers -- reference material and conventions.
They do NOT define agent behavior or personality. Each agent's system prompt
defines how it thinks and acts. Skills provide what it knows about a domain.
