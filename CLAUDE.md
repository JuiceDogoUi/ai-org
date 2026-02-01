# AI Organization Plugin

## Interaction Model
- Users invoke slash commands (e.g., /plan, /build, /review) for known workflows
- The orchestrator agent handles ambiguous or multi-domain requests
- Agents invoke skills as domain references; skills are NOT absorbed into agent identity
- Each agent has scoped skills declared in its frontmatter

## Agent Model Tiers
- **Opus**: Complex reasoning, architecture, strategy, orchestration
- **Sonnet**: Standard engineering, writing, review, product work
- **Haiku**: Fast lookup, code exploration, simple formatting, status checks

## Coordination Principle
Commands route directly to the best-fit agent. Only ambiguous or multi-step requests
go through the orchestrator. This avoids unnecessary token overhead.

## Skill Isolation
Skills are domain knowledge containers -- reference material and conventions.
They do NOT define agent behavior or personality. Each agent's system prompt
defines how it thinks and acts. Skills provide what it knows about a domain.
