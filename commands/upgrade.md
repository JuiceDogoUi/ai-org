---
name: upgrade
description: Upgrade ai-org setup to latest version
context: fork
agent: orchestrator
---

Upgrade this project's ai-org setup to incorporate any new agents, commands, and skills from the latest plugin version.

You MUST follow this workflow exactly. Do NOT modify any files until Phase 4, after the user confirms.

## Phase 1: Scan Current Setup

Read the project's current ai-org configuration:

- Read all files in `.claude/agents/` — note each agent's name, model, tools, skills, and system prompt
- Read all files in `.claude/commands/` — note each command's name, agent routing, and description
- Read all files in `.claude/guides/` — note topics covered
- Read `CLAUDE.md` — note the workspace scope tier (from agent reference table, conventions, or infer from which agents are present)
- Read `strategy/` directory structure if it exists
- Note the inferred tier:
  - Has eng-* agents but no product/design/strategy → Tier 1
  - Has eng-* agents AND product/design agents → Tier 2
  - Has eng-* + product + strategy/writing agents → Tier 3
  - Has product/design/strategy but no eng-* agents → Tier 4

## Phase 2: Compare Against Plugin

List all agents, commands, and skills available in the ai-org plugin:

- Read all files in the plugin's `agents/` directory
- Read all files in the plugin's `commands/` directory
- Read all `skills/*/SKILL.md` files in the plugin

For each plugin resource, check if a corresponding project resource exists:

- **Agents**: Match by name in `.claude/agents/` or by role mapping (read system prompts)
- **Commands**: Match by name in `.claude/commands/`
- **Skills**: Check if skills referenced by project agents exist in the plugin

Identify:
- New agents added to the plugin that don't exist in the project
- New commands added to the plugin that don't exist in the project
- New skills referenced by agents
- Skills with updated content

## Phase 3: Present Diff

Present a categorized upgrade report:

```
## Upgrade Available

### New in ai-org (not in your project)
- Agents: {list new agents with role descriptions}
- Commands: {list new commands with descriptions}
- Skills: {list new skills}

### Updated in ai-org
- Skills with new content: {list skills that have changed}

### Your project additions (will be preserved)
- Custom agents: {list agents not in ai-org}
- Custom commands: {list commands not in ai-org}

### Suggested actions
- Add {N} new agents for your tier ({tier name})
- Add {N} new commands for your tier
- {Other suggestions based on detected gaps}
```

Ask: "Which additions would you like to apply? (all / select specific items / none)"

## Phase 4: Execute

Only proceed after user confirms which items to apply.

### 4.1 Backup
Create `.claude/backup/{ISO-date-timestamp}/` containing a copy of every file that will be modified.

### 4.2 Add New Agents
For each new agent the user approved:
- Read the ai-org base agent file
- Create a project-specific version in `.claude/agents/` with:
  - Same frontmatter (name, model, tools, skills)
  - Project-specific system prompt using context from CLAUDE.md (project name, tech stack, business context)
  - Same section structure as other project agents

### 4.3 Add New Commands
For each new command the user approved:
- Read the ai-org base command file
- Create a project-specific version in `.claude/commands/` with project context (tech stack, project name)

### 4.4 Update Orchestrator
- Read the project's orchestrator agent
- Add routing entries for any new agents to its delegation decision tree
- Backup the original first

### 4.5 Update CLAUDE.md
- Add new agents to the agent reference table
- Update agent and command counts

## Phase 5: Report

Present a summary:

```
## Upgrade Complete

### Added
- {N} new agents: {list}
- {N} new commands: {list}

### Updated
- Orchestrator routing table: added {list of new routes}
- CLAUDE.md: updated agent reference table

### Backed Up
- All backups in: .claude/backup/{timestamp}/

### Files Created/Modified
- {list each file with action taken}
```
