# AI Organization Plugin

## Interaction Model
- Users invoke slash commands (e.g., /explore, /build, /review) for known workflows
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

## Hybrid Coordination Model
Complex commands use a hybrid of subagents and teams:
- **Subagents** for sequential phases (research, review) where peer communication is not needed
- **Teams** for parallel build phases where engineers need to coordinate directly
- Claude Code creates one team per build phase, manages its lifecycle, and tears it down after
- Only one team can exist at a time — sequential phases use subagents, not teams
- Engineering agents (eng-frontend, eng-backend, eng-api, eng-styles, eng-testing) are
  team-aware and can coordinate via SendMessage and shared task lists when spawned as teammates

## Documentation Freshness
When writing code that uses external libraries, agents must use WebSearch or WebFetch
to verify current API signatures before generating code. Do not rely on training data
for library APIs — always check official docs for accurate function signatures, parameters,
and return types. If docs contradict training data, trust the docs.

## Skill Isolation
Skills are domain knowledge containers -- reference material and conventions.
They do NOT define agent behavior or personality. Each agent's system prompt
defines how it thinks and acts. Skills provide what it knows about a domain.
