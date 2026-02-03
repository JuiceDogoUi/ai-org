---
name: upgrade
description: Upgrade ai-org setup to latest version
argument-hint: "[optional: specific items]"
context: fork
model: opus
---

# Upgrade: $ARGUMENTS

You are Claude Code. Upgrade this project's ai-org setup to incorporate any new agents, commands, skills, and guides from the latest plugin version.

You MUST follow this workflow exactly. Do NOT modify any files until Phase 4, after the user confirms.

## Phase 1: Scan Current Setup

Read the project's current ai-org configuration:

### 1.0 Version Check
- Read `.claude/version.json` if it exists — note the `aiOrgVersion` and `installedAt` timestamp
- If no version file exists, this project predates version tracking (treat as "unknown version")
- Current plugin version is `1.0.0` — compare against project's `aiOrgVersion` to determine what's new

### 1.1 Configuration Files
- Read all files in `.claude/agents/` — note each agent's name, model, tools, skills, and system prompt
- Read all files in `.claude/commands/` — note each command's name, agent routing, and description
- Read all files in `.claude/guides/` — note topics covered
- List all directories in `.claude/skills/` — note which skills are installed locally
- Read `CLAUDE.md` — note project name, tech stack, business context, and workspace scope tier

### 1.2 Project Structure
- Check `strategy/` directory at project root — note what exists (foundation, research, etc.)
- Check `initiatives/` directory at project root — note if it exists
- Check `.claude/plans/` — note if it exists

### 1.3 Detect Tech Stack
- Read `package.json`, `tsconfig.json`, framework configs to determine current stack
- Record: frontend framework, backend framework, database, CSS approach
- Check for monorepo indicators: `turbo.json`, `nx.json`, `lerna.json`, `pnpm-workspace.yaml`

### 1.4 Infer Current Tier

Based on which agents exist:
- **Tier 1 (Coding only)**: Has eng-* agents but NO product-lead, design-lead, positioning, or researcher
- **Tier 2 (Coding + Product & Design)**: Has eng-* agents AND product-lead/design-lead, but NO positioning or researcher
- **Tier 3 (Full stack)**: Has eng-* agents AND product-lead AND positioning/researcher/compliance
- **Tier 4 (Product & Strategy only)**: Has product-lead, positioning, researcher but NO eng-* agents

**Edge cases**:
- Has eng-* + positioning but no product-lead → Tier 1 with custom additions (suggest completing Tier 2 first)
- Has eng-* + product-lead + researcher but no positioning → Incomplete Tier 3 (offer to complete)
- Has only writer-lead → Minimal setup (ask user which tier to upgrade to)

## Phase 2: Compare Against Plugin

### 2.1 Read Plugin Resources
- Read all files in the plugin's `agents/` directory
- Read all files in the plugin's `commands/` directory
- Read all `skills/*/SKILL.md` files in the plugin

### 2.2 Determine Applicable Resources

**Filter by tier** — only suggest resources appropriate for the project's tier:
- Tier 1 (Coding only): eng-architect, eng-* agents, reviewer-code, reviewer-architecture, writer-lead
- Tier 2 (Coding + Product): Tier 1 + product-lead, design-lead
- Tier 3 (Full stack): Tier 2 + positioning, researcher, reviewer-content, compliance
- Tier 4 (Product & Strategy): writer-lead, product-lead, design-lead, positioning, researcher, reviewer-content, compliance (NO eng-* agents)

**Filter skills by stack** — only suggest skills matching the detected tech stack:

| Stack / Framework | Applicable Skills |
|-------------------|-------------------|
| TypeScript/JavaScript | typescript, javascript |
| Angular | angular, typescript, css-architecture, accessibility |
| React / Next.js / Remix | react, typescript, javascript, css-architecture, accessibility |
| Vue / Nuxt | vue, typescript, javascript, css-architecture, accessibility |
| Svelte / SvelteKit | svelte, typescript, javascript, css-architecture, accessibility |
| Astro | typescript, javascript, css-architecture, accessibility |
| Swift / iOS | swift |
| Kotlin / Android | kotlin |
| React Native | react, javascript, typescript, accessibility |
| Flutter / Dart | dart, accessibility |
| Electron | electron, typescript, javascript |
| Tauri | typescript, javascript, rust |
| Spring Boot / Java | java |
| Django / FastAPI / Flask | (no Python skill yet — note only) |
| Gin / Echo / Go | (no Go skill yet — note only) |
| Rails / Ruby | (no Ruby skill yet — note only) |
| Any with database | database-design |
| Any with API | api-design |
| Any with backend/infrastructure | devops |

Universal skills (coding tiers): i18n, testing-strategy, security, performance

Product/Strategy skills (Tiers 2, 3, 4): product-management, product-analytics, positioning, research-methodology, competitive-analysis, content-strategy, ux-writing, marketing-copy, technical-writing, compliance-frameworks, review-process

### 2.3 Identify Gaps

Compare and identify:
- **New agents**: In plugin but not in project (filtered by tier)
- **New commands**: In plugin but not in project (filtered by tier)
- **New guides**: In plugin but not in project
- **New skills**: Applicable to the project's stack but not present in `.claude/skills/`
- **Updated skills**: Skills in `.claude/skills/` where the plugin version has substantive changes
- **Updated agent tools**: Agents where the plugin's `tools:` list differs from the project's version
- **Missing directories**: `initiatives/` or `strategy/` missing for the tier

**Skill comparison method**: Compare each skill directory in `.claude/skills/` against the plugin's version:
1. Read the project's `.claude/skills/{skill}/SKILL.md`
2. Read the plugin's `skills/{skill}/SKILL.md`
3. A skill is "updated" if:
   - The plugin's SKILL.md has new sections not in the project version
   - The plugin's SKILL.md is significantly larger (>20% more content)
   - The plugin's skill directory contains new supporting files

**Important**: Skills are copied to `.claude/skills/` so users can customize them. Updated skills require user confirmation before overwriting (they may have made local changes).

## Phase 3: Present Diff

Present a categorized upgrade report:

```
## Upgrade Available

### Current Setup
- Tier: {detected tier}
- Tech stack: {detected stack}
- Agents: {count} installed
- Commands: {count} installed

### New in ai-org (applicable to your tier and stack)
- Agents: {list new agents with role descriptions}
- Commands: {list new commands with descriptions}
- Guides: {list new guides}
- Skills: {list new skills applicable to your stack}

### Updated in ai-org
- Skills with new content: {list skills that have changed, with brief description of what's new}
- Agent tools changed: {list agents where plugin tools differ from project tools}

### Missing Structure
- Directories: {list any missing directories like initiatives/, strategy/}

### Your project additions (will be preserved)
- Custom agents: {list agents not in ai-org}
- Custom commands: {list commands not in ai-org}
- Custom guides: {list guides not in ai-org}

### Suggested actions
- Add {N} new agents for Tier {N}
- Add {N} new commands
- Add {N} new guides
- Update {N} skills with new content
- Create missing directories: {list}
```

Ask: "Which additions would you like to apply? (all / select specific items / none)"

## Phase 4: Execute

Only proceed after user confirms which items to apply.

### 4.1 Backup
Create `.claude/backup/{ISO-date-timestamp}/` containing a copy of every file that will be modified.

### 4.2 Create Missing Directories
For any missing directories the user approved:
- Create `initiatives/` with `.gitkeep` if missing
- Create `strategy/foundation/`, `strategy/research/competitors/`, `strategy/research/market/` with `.gitkeep` files if missing (Tiers 2, 3, 4 only)
- Create `.claude/plans/` with `.gitkeep` if missing

### 4.3 Add New Agents
For each new agent the user approved:
- Read the ai-org base agent file
- Create a project-specific version in `.claude/agents/` with:
  - Same frontmatter (name, model, tools)
  - Skills filtered to only those applicable to this project's stack
  - Project-specific system prompt using context from CLAUDE.md (project name, tech stack, business context)
  - Same section structure as other project agents

### 4.4 Add New Commands
For each new command the user approved:
- Read the ai-org base command file
- Create a project-specific version in `.claude/commands/` with project context (tech stack, project name)

### 4.5 Add New Guides
For each new guide the user approved:
- Read the ai-org base guide file
- Create a project-specific version in `.claude/guides/` populated with project context

### 4.6 Add/Update Skills

**CRITICAL: You MUST copy skill files to the project. Skills are NOT automatically available from the plugin.**

First, find the plugin path by running:
```bash
# The plugin is typically at one of these locations:
ls -la ~/.claude/plugins/ai-org/skills/ 2>/dev/null || \
ls -la /Volumes/LaCie/Work/Apps/ai-org/skills/ 2>/dev/null || \
echo "Plugin path not found - ask user for ai-org location"
```

For each new skill the user approved:
1. Create the directory: `mkdir -p .claude/skills/{skill-name}/`
2. Copy ALL files from the plugin's skill directory:
   ```bash
   cp -r {plugin-path}/skills/{skill-name}/* .claude/skills/{skill-name}/
   ```
3. Verify the copy succeeded by listing the files

For each updated skill the user approved:
- **Warning**: This will overwrite any local customizations
- Backup first: `cp -r .claude/skills/{skill-name} .claude/backup/{timestamp}/`
- Then copy the updated skill from the plugin

### 4.7 Update Agent Tools
For each agent tools update the user approved:
- Read the plugin's agent file to get the updated `tools:` list
- Update the project agent's frontmatter to match
- Do NOT change the agent's system prompt — only update frontmatter

### 4.8 Update CLAUDE.md
Locate and update these specific sections:

**Agent Reference table** (usually near the top):
- Add new agents in a new row: `| {agent-name} | {model} | {one-line purpose} |`

**Installed Skills section**:
- Add new skills to the bullet list: `- {skill-name}`

**Counts** (if present):
- Update "X agents" and "Y commands" counts in any summary sections

**Project Structure section** (if new directories were created):
- Add entries for new directories like `initiatives/` or `strategy/`

### 4.9 Update Version File
Create or update `.claude/version.json`:
```json
{
  "aiOrgVersion": "1.0.0",
  "installedAt": "{original install date, preserve if exists}",
  "lastUpgraded": "{ISO timestamp of this upgrade}"
}
```

## Phase 5: Report

Present a summary:

```
## Upgrade Complete

### Version
- Previous: {version or "unknown"}
- Current: {new version}

### Added
- {N} new agents: {list}
- {N} new commands: {list}
- {N} new guides: {list}
- {N} new skills: {list} (copied to .claude/skills/)

### Updated
- CLAUDE.md: updated agent reference table, skills list
- Skills: {list skills that were updated} (originals backed up)
- Agent tools: {list agents with updated tools}

### Created Directories
- {list any directories created}

### Backed Up
- All backups in: .claude/backup/{timestamp}/

### Files Created/Modified
- {list each file with action taken}

### Rollback Instructions
If you need to revert this upgrade:
1. Copy files from `.claude/backup/{timestamp}/` back to their original locations
2. Delete any newly created files listed above
3. Delete or revert `.claude/version.json` to previous state
```

> Related: `/migrate` to migrate an existing project, `/onboard` to set up a new project from scratch.
