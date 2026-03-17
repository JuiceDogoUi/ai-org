# AI Organization Plugin

## Interaction Model
- Users invoke slash commands (e.g., /explore, /build, /review) for known workflows
- Claude Code acts as the team lead, creating agent teams for complex workflows and spawning single agents for simple tasks
- Workflow commands use TeamCreate/TeamDelete for parallel phases, subagents for sequential work
- Agents invoke skills as domain references; skills are NOT absorbed into agent identity
- Each agent has scoped skills declared in its frontmatter

## Agent Model Tiers
- **Opus**: Complex reasoning, architecture, strategy, multi-stage workflows
- **Sonnet**: Standard engineering, review, product work
- **Haiku**: Fast lookup, code exploration, simple formatting, status checks

## Coordination Principle
Claude Code acts as the team lead. Workflow commands create agent teams with shared task
lists, direct messaging, and parallel execution. Simple commands spawn a single agent.

## Team Orchestration Model
Complex commands (/feature, /build, /review) use agent teams:
- **Team lead** (Claude Code) creates teams, spawns teammates, coordinates work
- **Teammates** work in parallel, communicate directly via SendMessage
- **Shared task list** with TaskCreate/TaskUpdate — teammates self-claim unblocked tasks
- **Challenger** is a permanent team member, not a separate gate — reviews at key inflection points
- Teams are created per phase (build team, review team) and torn down after
- Subagents used for sequential single-agent work (research, testing) where peer communication is not needed

## Documentation Freshness
When writing code that uses external libraries, agents must use WebSearch or WebFetch
to verify current API signatures before generating code. Do not rely on training data
for library APIs — always check official docs for accurate function signatures, parameters,
and return types. If docs contradict training data, trust the docs.

## Skill Isolation
Skills are domain knowledge containers -- reference material and conventions.
They do NOT define agent behavior or personality. Each agent's system prompt
defines how it thinks and acts. Skills provide what it knows about a domain.
