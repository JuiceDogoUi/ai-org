---
name: upgrade
description: Upgrade ai-org setup to latest version
context: fork
agent: orchestrator
---

Upgrade this project's ai-org setup to incorporate any new agents, commands, skills, and guides from the latest plugin version.

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
- Has only orchestrator and writer-lead → Minimal setup (ask user which tier to upgrade to)

## Phase 2: Compare Against Plugin

### 2.1 Read Plugin Resources
- Read all files in the plugin's `agents/` directory
- Read all files in the plugin's `commands/` directory
- Read all `skills/*/SKILL.md` files in the plugin

### 2.2 Determine Applicable Resources

**Filter by tier** — only suggest resources appropriate for the project's tier:
- Tier 1 (Coding only): orchestrator, eng-architect, eng-* agents, reviewer-code, reviewer-architecture, writer-lead
- Tier 2 (Coding + Product): Tier 1 + product-lead, design-lead
- Tier 3 (Full stack): Tier 2 + positioning, researcher, reviewer-content, compliance
- Tier 4 (Product & Strategy): orchestrator, writer-lead, product-lead, design-lead, positioning, researcher, reviewer-content, compliance (NO eng-* agents)

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
- **New skills**: Referenced by plugin agents but not installed in project's agent frontmatter
- **Updated skills**: Skills where the plugin's `SKILL.md` has substantive content changes (compare file contents, not just timestamps)
- **Updated agent tools**: Agents where the plugin's `tools:` list differs from the project's version
- **Missing directories**: `initiatives/` or `strategy/` missing for the tier

**Skill comparison method**: To detect updated skills, read each installed skill's `SKILL.md` from the plugin and compare against what the project's agents reference. A skill is "updated" if:
1. The plugin's SKILL.md has new sections not previously present
2. The plugin's SKILL.md has significantly expanded content (>20% larger)
3. The plugin's skill directory contains new supporting files (templates, examples)

Note: Skills are referenced, not copied — the project always uses plugin skill content at runtime. "Updated skills" just means the user should be aware of new capabilities.

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

### 4.6 Update Skills and Tools
For each skill update the user approved:
- Skills are referenced by agents, not copied to the project
- Update the agent frontmatter to reference any new skills
- Note: Skill content comes from the plugin at runtime

For each agent tools update the user approved:
- Read the plugin's agent file to get the updated `tools:` list
- Update the project agent's frontmatter to match
- Do NOT change the agent's system prompt — only update frontmatter

### 4.7 Update Orchestrator
- Read the project's orchestrator agent
- Backup the original first
- Find the `## Delegation` or `## Agent Routing` section in the system prompt
- Add routing entries for any new agents using this format:

```markdown
## Delegation (updated)
...existing entries...
{N}. Is it {new agent's domain}? → {new-agent-name}
```

Example: If adding `eng-performance`, add:
```
12. Is it performance optimization or profiling? → eng-performance
```

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

### Updated
- Orchestrator routing table: added {list of new routes}
- CLAUDE.md: updated agent reference table, skills list
- Agent skills: {list agents with new skill references}
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
