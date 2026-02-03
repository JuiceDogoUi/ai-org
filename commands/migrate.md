---
name: migrate
description: Migrate an existing project to ai-org agents and structure
argument-hint: "[optional: tier scope]"
context: fork
model: opus
---

# Migrate: $ARGUMENTS

You are Claude Code. Migrate this existing project to use ai-org conventions, agents, and structure.

You MUST follow this workflow exactly. Do NOT modify any files before presenting the migration plan and getting user confirmation.

## Phase 1: Automatic Scan

Scan the project without asking the user anything. Gather all available context:

### 1.1 Detect Tech Stack

#### Web / General
- Check for `package.json` (name, dependencies, scripts, devDependencies)
- Check for `tsconfig.json` or `tsconfig.base.json`
- Check for `angular.json` or `.angular-cli.json`
- Check for `next.config.*`, `nuxt.config.*`, `vite.config.*`, `svelte.config.*`, `astro.config.*`, `remix.config.*`
- Check for `pom.xml`, `build.gradle`, `build.gradle.kts` (without Android plugin)
- Check for `Dockerfile`, `docker-compose.yml`
- Check for `.github/workflows/` (CI/CD patterns)
- Check for `.eslintrc*`, `.prettierrc*`, `jest.config.*`, `vitest.config.*` (code quality tools)

#### Python
- Check for `requirements.txt`, `pyproject.toml`, `setup.py`, `Pipfile`
- Check for `manage.py` (Django indicator)
- Check for FastAPI/Flask imports in main entry files

#### Go
- Check for `go.mod`, `go.sum`
- Check for `main.go` or `cmd/` directory structure

#### Ruby
- Check for `Gemfile`, `Gemfile.lock`
- Check for `config/routes.rb` (Rails indicator)

#### ORM / Database Tools
- Check for `prisma/schema.prisma` (Prisma)
- Check for `drizzle.config.*` (Drizzle)
- Check for `ormconfig.*` or `typeorm` in dependencies (TypeORM)
- Check for `sequelize` in dependencies (Sequelize)
- Check for `alembic/` directory (SQLAlchemy migrations)

#### Monorepo
- Check for `turbo.json` (Turborepo)
- Check for `nx.json` (Nx)
- Check for `lerna.json` (Lerna)
- Check for `pnpm-workspace.yaml` (pnpm workspaces)
- Check for `packages/` or `apps/` directories
- If monorepo detected, scan each app/package for its own stack

#### Mobile
- Check for `Package.swift`, `*.xcodeproj`, `*.xcworkspace` → iOS native (Swift)
- Check for `build.gradle.kts` with `com.android.application` plugin → Android native (Kotlin)
- Check for `package.json` with `react-native` dependency → React Native
- Check for `pubspec.yaml` with `flutter` dependency → Flutter (Dart)

#### Desktop
- Check for `package.json` with `electron` dependency → Electron
- Check for `src-tauri/` directory or `tauri.conf.json` → Tauri (Rust backend)
- Check for `*.xcodeproj` with macOS target → Native macOS (Swift/AppKit)
- Check for `*.csproj` with WPF/WinUI references → Native Windows

#### Examine project structure
- Examine `src/`, `app/`, `lib/` directory structure to understand the project layout
- Record the detected platform: web, iOS, Android, cross-platform-mobile, desktop

### 1.2 Scan Existing Claude Configuration

- Read `CLAUDE.md` if it exists — note its full content and structure
- List `.claude/` directory if it exists
- Read ALL files in `.claude/agents/` — note each agent's name, model, tools, skills, and system prompt
- Read ALL files in `.claude/commands/` — note each command's routing
- Read ALL files in `.claude/guides/` — note what topics they cover
- Check `strategy/` at the project root — note what exists (foundation, research, etc.)
- Check `.claude/strategy/` — detect if strategy is in the old location
- Check `initiatives/` at the project root — note if it exists and what initiatives are present
- Check `.claude/plans/` — note any existing plans

### 1.3 Understand Project Context

- Read `README.md` if it exists — extract project description, purpose, audience
- Read `DESIGN_SYSTEM.md` or similar design docs if they exist
- Examine key source directories to understand architecture patterns

### 1.4 Auto-Detect Workspace Scope Tier

Based on the scan results, determine the suggested installation tier:

- **Tier 1 (Coding only)**: Has eng-* agents or code source files, but NO product-lead, design-lead, positioning, or researcher
- **Tier 2 (Coding + Product & Design)**: Has eng-* agents or code files AND product-lead/design-lead, but NO positioning or researcher
- **Tier 3 (Full stack)**: Has eng-* agents or code files AND product-lead AND positioning/researcher/compliance
- **Tier 4 (Product & Strategy only)**: Has product-lead, positioning, researcher but NO eng-* agents and NO code source files

**Edge cases and resolution**:
- Code files exist but no agents at all → Suggest Tier 1, let user choose higher
- Has eng-* + positioning but no product-lead → Suggest Tier 1 (positioning is an orphan); recommend completing Tier 2 first or removing positioning
- Has eng-* + product-lead + researcher but no positioning → Incomplete Tier 3; suggest completing Tier 3 by adding positioning
- Has only minimal agents → Ask user which tier they want
- Has strategy/ directory but no strategy agents → Suggest Tier 2 minimum to make use of strategy docs
- CLAUDE.md mentions a tier explicitly → Use that as the starting suggestion

### 1.5 Idempotency Check

Before proceeding, check if this project has already been migrated:
- Look for `<!-- ai-org enhanced sections below -->` delimiter in CLAUDE.md
- Check for `.claude/version.json`
- Check if existing agents already have `skills:` fields in frontmatter

If ALL of these are present, report: "This project appears to already have ai-org setup. Consider using `/upgrade` instead to update to the latest version." Ask user if they want to proceed anyway (will re-apply migration, potentially duplicating enhancements).

## Phase 2: Role Mapping and Questions

### 2.1 Map Existing Agents to ai-org Roles

This is critical. For each existing agent, determine which ai-org role it covers by reading its system prompt and description. Build a role mapping table:

| ai-org Role | Existing Agent | Confidence | Notes |
|-------------|---------------|------------|-------|
| eng-frontend | nextjs-developer | high | Both handle frontend component implementation |
| writer-lead | content-writer | high | Both handle writing tasks |
| eng-security | security-auditor | high | Both do security analysis |
| eng-testing | test-engineer | high | Both handle test strategy and writing |
| compliance | compliance-regulator | high | Both handle regulatory compliance |
| eng-devops | (none) | n/a | No existing agent covers this role — will CREATE if user approves |
| eng-backend | (none) | n/a | No existing agent covers this role — will CREATE if user approves |

Use `(none)` for uncovered roles. One existing agent may cover multiple ai-org roles (e.g., a "full-stack-dev" agent might cover both eng-frontend and eng-backend). In that case, list it for each role it covers.

An existing agent COVERS an ai-org role if its system prompt describes substantially the same responsibilities, even if the name is different. One existing agent may cover multiple ai-org roles, or one ai-org role may be split across multiple existing agents.

### 2.2 Present Findings

Present a clear summary to the user:

```
## Scan Results

### Detected Tech Stack
- Language: {detected}
- Frontend: {detected or "none"}
- Backend: {detected or "none"}
- Database: {detected or "none"}
- CSS: {detected or "none"}
- CI/CD: {detected or "none"}

### Existing Claude Configuration
- CLAUDE.md: {found/not found} ({line count} lines)
- Agents: {count} found ({list names})
- Commands: {count} found ({list names})
- Guides: {count} found ({list names})
- Strategy: {found at strategy/ / found at .claude/strategy/ (old location) / not found}

### Role Mapping
The following existing agents match ai-org roles:
- {existing-agent-name} → covers ai-org role: {ai-org-role}
- {existing-agent-name} → covers ai-org role: {ai-org-role}
- ...

### Uncovered Roles
These ai-org roles have no equivalent existing agent (full list — will be filtered to your chosen tier in the next step):
- {ai-org-role}: {what it does}
- {ai-org-role}: {what it does}
- ...

### Suggested Workspace Scope

Based on your project, we suggest **{tier name}**: {tier description}.

Reason: {explain what was detected that led to this suggestion}
```

Then ask:
1. Is the role mapping correct? Should any mappings be changed?
2. **Workspace scope** — is the suggested tier correct? (present all 4 options):
   - **Tier 1 (Coding only)** — engineering agents, code review, technical docs
   - **Tier 2 (Coding + Product & Design)** — adds PRDs, UX research, UI specs, design system
   - **Tier 3 (Full stack)** — adds strategy, positioning, content writing, marketing, compliance
   - **Tier 4 (Product & Strategy only)** — no coding agents; only product, design, strategy, and writing
3. Do you want agents created for the uncovered roles within the chosen tier?

The confirmed tier controls which uncovered roles get offered for creation. Do NOT offer to create agents outside the chosen tier scope (e.g., don't offer eng-frontend for Tier 4, don't offer positioning for Tier 1).

## Phase 3: Present Migration Plan

Based on scan results, role mapping, and user answers, create a categorized migration plan. Present it clearly and ask for confirmation before executing.

### Categories

**PRESERVE** — Existing files that will be left completely untouched:
- All existing agent files that cover an ai-org role (they already work — do not create duplicates)
- All existing commands that reference existing agents
- All existing guides and strategy documents
- List each file and why it's being preserved

**ENHANCE** — Existing files that will have ai-org enhancements added:
- Existing agents: add `skills:` field to frontmatter if missing (mapping to appropriate ai-org skill domains based on the agent's detected role)
- Backup location: `.claude/backup/{ISO-date-timestamp}/{original-filename}` — created before any modification
- Do NOT change the agent's name, model, tools, or system prompt — only add skills references

**ENHANCE CLAUDE.md** (if exists):
- Append ai-org sections below a `<!-- ai-org enhanced sections below -->` delimiter
- Add: Agent Reference table that lists BOTH existing agents AND new agents, with their role mapping
- Add: Model Tiers, Skill Isolation sections
- Do NOT modify any existing content above the delimiter

**CREATE** — New files only for UNCOVERED roles within the chosen tier:
- Only create new ai-org agents for roles that NO existing agent covers AND that fall within the user's chosen workspace scope tier
- Use the tier-to-agent mapping defined in section 4.7 below
- New agents get project-specific system prompts based on scan results
- Each new agent's prompt includes: "Always read CLAUDE.md for project conventions before starting work."
- List each file and its purpose

Present the full plan and ask: "Proceed with this migration plan?"

## Phase 4: Execute Migration

Only proceed after user confirms.

### 4.1 Create Backup

Create `.claude/backup/{ISO-date-timestamp}/` containing an exact copy of every file that will be modified (ENHANCE category only). Do NOT back up files that are only being created.

### 4.2 Determine Skills to Install

Based on the detected tech stack from Phase 1, determine which skills are relevant. **Only install skills that match the project's actual stack.**

| Stack / Framework | Skills to Install |
|-------------------|-------------------|
| TypeScript/JavaScript (any) | typescript, javascript |
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
| Django / FastAPI / Flask | (no Python skill yet — note in CLAUDE.md) |
| Gin / Echo / Go | (no Go skill yet — note in CLAUDE.md) |
| Rails / Ruby | (no Ruby skill yet — note in CLAUDE.md) |
| Any with database | database-design |
| Any with API | api-design |
| Any with backend/infrastructure | devops |

Universal skills (always install for coding tiers): i18n, testing-strategy, security, performance

Product/Strategy skills (Tiers 2, 3, 4): product-management, product-analytics, positioning, research-methodology, competitive-analysis, content-strategy, ux-writing, marketing-copy, technical-writing, compliance-frameworks, review-process

### 4.3 Copy Skills to Project

**CRITICAL: You MUST copy skill files to the project. Skills are NOT automatically available from the plugin.**

First, find the plugin path by running:
```bash
ls -la ~/.claude/plugins/ai-org/skills/ 2>/dev/null || \
ls -la /Volumes/LaCie/Work/Apps/ai-org/skills/ 2>/dev/null || \
echo "Plugin path not found - ask user for ai-org location"
```

For each skill to install:
1. Check if it already exists: `ls .claude/skills/{skill-name}/ 2>/dev/null`
2. If it exists, SKIP it (user may have customized) and note it was skipped
3. If it doesn't exist:
   - Create the directory: `mkdir -p .claude/skills/{skill-name}/`
   - Copy ALL files: `cp -r {plugin-path}/skills/{skill-name}/* .claude/skills/{skill-name}/`
   - Verify: `ls -la .claude/skills/{skill-name}/`

This allows users to:
- Customize skills for their project's specific conventions
- Update skills independently of the plugin
- Add project-specific patterns and examples

### 4.4 Enhance Existing Agents

For each existing agent that maps to an ai-org role:
- Add `skills:` field to frontmatter if missing, mapping to the appropriate ai-org skill domains **from the installed skills list only**:
  - Frontend agent → skills from: [react, angular, vue, svelte, typescript, javascript, css-architecture, accessibility, i18n] (only those detected)
  - Styles agent → skills from: [css-architecture, accessibility, performance, i18n] (only those detected)
  - Backend agent → skills from: [database-design, api-design, devops, java, typescript, i18n] (only those detected)
  - Mobile agent → skills from: [swift, kotlin, dart, react, javascript, typescript, accessibility, i18n] (only those detected)
  - Desktop agent → skills from: [electron, typescript, javascript, swift, rust, i18n] (only those detected)
  - Content agent → skills: [content-strategy, ux-writing, marketing-copy, technical-writing]
  - Security agent → skills: [security]
  - Testing agent → skills: [testing-strategy]
  - DevOps agent → skills: [devops, security]
  - Architecture agent → skills: [api-design, database-design, security, performance]
  - (Map each based on the role mapping from Phase 2 and detected stack from Phase 1)
- Ensure frontmatter has all required fields: name, description, model, tools
- Do NOT change the system prompt, name, model, or tools
- Do NOT rename the agent file

### 4.5 Enhance CLAUDE.md

**If exists**: Append below existing content after `<!-- ai-org enhanced sections below -->`:
- Installed Skills table listing only the skills that were installed (from section 4.2)
- Agent Reference table listing ALL agents (existing + new) with their role
- Note which agents are project-original and which are ai-org additions
- Model Tiers, Skill Isolation sections

**If not exists**: Create from scratch using detected tech stack and project context from README. Include:
- Installed Skills table
- Project structure section explaining:
  - `.claude/` — Claude Code configuration only (agents, commands, guides, plans)
  - `initiatives/` — Feature work with research, specs, and review reports (at project root)
  - `strategy/` — Product and research team documents (at project root, Tiers 2, 3, 4 only)

### 4.6 Create Missing Agents

For uncovered roles only (roles where NO existing agent was mapped) AND within the chosen tier. **Only assign skills from the installed skills list (section 4.2).**

**Tier-to-Agent Mapping** (which agents belong to which tier):

| Tier | Agents Included |
|------|-----------------|
| **Tier 1 (Coding only)** | eng-architect, eng-testing, eng-security, reviewer-code, reviewer-architecture, writer-lead (technical-writing only), + stack-conditional: eng-frontend, eng-styles (if UI), eng-backend, eng-api (if backend), eng-devops, eng-performance (if team 2+) |
| **Tier 2 (Coding + Product)** | All Tier 1 + product-lead, design-lead. writer-lead gains full skills. |
| **Tier 3 (Full stack)** | All Tier 2 + positioning, researcher, reviewer-content, compliance |
| **Tier 4 (Product & Strategy)** | writer-lead, product-lead, design-lead, positioning, researcher, reviewer-content, compliance. NO eng-* agents. |

**Creation rules**:
- For Tier 1: do NOT create positioning, researcher, reviewer-content, compliance, or product/design agents
- For Tier 2: do NOT create positioning, researcher, reviewer-content, or compliance
- For Tier 4: do NOT create any eng-* agents, reviewer-code, or reviewer-architecture
- Use ai-org frontmatter (name, model, tools, skills)
- Write project-specific system prompts using information from the scan
- Each new agent includes: "Always read CLAUDE.md for project conventions before starting work."
- Reference the actual project name, tech stack, and conventions detected

### 4.7 Create Missing Structure

**Guides** (if `.claude/guides/` is missing or incomplete):
- `development.md` — For Tiers 1-3: populated from detected package.json scripts, build tools, linting config. For Tier 4: document workflow overview, folder structure conventions, available slash commands.
- `contributing.md` — populated from detected code quality tools and conventions
- `content-creation.md` — Tiers 3 and 4 only. Content workflow: brand voice, target personas, SEO, review process, publishing checklist.

**Strategy** (Tiers 2, 3, and 4 only — skip for Tier 1):
If `strategy/` is missing or incomplete at the project root:
- `strategy/foundation/personas.md` — template skeleton
- `strategy/foundation/positioning.md` — template skeleton (structured per the positioning skill's canvas format)
- `strategy/research/competitors/.gitkeep`
- `strategy/research/market/.gitkeep`

If strategy files are found at `.claude/strategy/` (old location), offer to move them to `strategy/` at the project root with a backup.

**Commands** (if `.claude/commands/` is missing or empty):
Generate project-level commands that route to the project's agents (using actual agent names from the role mapping).

**Tier-to-Command Mapping**:

| Command | Tiers | Model | Notes |
|---------|-------|-------|-------|
| plan.md | All | sonnet | Create implementation plan |
| build.md | All | opus | Build a feature with agent spawning |
| feature.md | All | opus | Full product workflow with stages |
| review.md | All | sonnet | 3-round review with agent spawning |
| docs.md | All | sonnet | Generate documentation (spawns writer-lead) |
| changelog.md | All | haiku | Generate changelog |
| status.md | All | haiku | Project status report |
| test.md | 1, 2, 3 | sonnet | Write tests (spawns eng-testing) |
| component.md | 1, 2, 3 | sonnet | Scaffold UI component (spawns eng-frontend) |
| db-migrate.md | 1, 2, 3 | sonnet | Database migration (spawns eng-backend) |
| refactor.md | 1, 2, 3 | sonnet | Refactor with pre/post review |
| perf.md | 1, 2, 3 | sonnet | Performance analysis (spawns eng-performance) |
| deploy.md | 1, 2, 3 | sonnet | Deployment workflow (spawns eng-devops) |
| audit.md | 1, 2, 3 | sonnet | Security audit with agent spawning |
| prd.md | 2, 3, 4 | sonnet | Product requirements (spawns product-lead) |
| position.md | 3, 4 | sonnet | Product positioning (spawns positioning) |
| research.md | 3, 4 | sonnet | Deep research (spawns researcher) |
| article.md | 3, 4 | sonnet | Blog post or article (spawns writer-lead) |
| copywrite.md | 3, 4 | sonnet | Marketing or UX copy (spawns writer-lead) |

Each command includes project-specific context (detected tech stack, project name from README). Read the corresponding ai-org plugin command files and adapt their workflows to reference the project's specifics.

**Directories** (if missing):
- `.claude/plans/`
- `initiatives/`

**Version file**:
Create `.claude/version.json`:
```json
{
  "aiOrgVersion": "1.0.0",
  "installedAt": "{ISO timestamp}",
  "migratedFrom": "existing-project"
}
```

## Phase 5: Migration Report

After execution, present a clear report:

```
## Migration Report

### Detected Stack
- {list all detected technologies}

### Workspace Scope
- Tier: {tier name} ({auto-detected / user-selected})

### Role Mapping Applied
| ai-org Role | Agent Used | Source |
|-------------|-----------|--------|
| eng-frontend | {name} | existing (enhanced with skills) |
| eng-backend | eng-backend | new (created) |
| writer-lead | {name} | existing (enhanced with skills) |
| ... | ... | ... |

### Preserved (existing files, untouched)
- {each file with reason}

### Enhanced (existing files, skills added)
- {each agent} → added skills: [{skills}], backup at {path}

### CLAUDE.md
- {enhanced with ai-org sections / created from scratch} → backup at {path}

### Commands Generated
- {count} project commands created in .claude/commands/
- {list each command and which agent it routes to}

### Skills Copied
- {count} skills copied to .claude/skills/
- {list each skill}
- Skipped (already existed): {list any skills that were not copied because they already existed}

### Created (new files)
- {each file with purpose}

### Backed Up
- All backups in: .claude/backup/{timestamp}/

### Folder Restructuring
- Strategy location: {strategy/ at root / moved from .claude/strategy/ to strategy/ / created new}

### Next Steps
- Review enhanced CLAUDE.md — merge ai-org sections as needed
- Review skills added to existing agents — verify they are appropriate
- Customize skills in `.claude/skills/` to match your project's conventions
- (Tiers 2, 3, 4 only) Fill in strategy templates if not already done
```

## Rules

- NEVER delete existing files
- NEVER overwrite existing files without creating a backup first
- NEVER modify existing system prompt content in agent files (only add/fix frontmatter)
- NEVER create a new agent for a role already covered by an existing agent
- NEVER rename existing agent files
- Always preserve existing content when enhancing files
- Detect tech stack automatically — do not ask the user to specify what is detectable
- Use detected project patterns in generated agents
- Map existing agents to ai-org roles by reading their system prompts, not by name matching
- Ask for user confirmation before executing the migration plan
- If the project already has a complete ai-org setup, report "already migrated" and suggest manual customization

> Related: `/upgrade` to update an existing ai-org setup, `/onboard` to set up a new project from scratch.
