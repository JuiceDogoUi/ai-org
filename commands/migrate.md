---
name: migrate
description: Migrate an existing project to ai-org agents and structure
context: fork
agent: orchestrator
---

Migrate this existing project to use ai-org conventions, agents, and structure.

You MUST follow this workflow exactly. Do NOT modify any files before presenting the migration plan and getting user confirmation.

## Phase 1: Automatic Scan

Scan the project without asking the user anything. Gather all available context:

### 1.1 Detect Tech Stack

- Check for `package.json` (name, dependencies, scripts, devDependencies)
- Check for `tsconfig.json` or `tsconfig.base.json`
- Check for `angular.json` or `.angular-cli.json`
- Check for `next.config.*` or `nuxt.config.*` or `vite.config.*`
- Check for `pom.xml`, `build.gradle`, `build.gradle.kts`
- Check for `Package.swift`, `*.xcodeproj`
- Check for `Dockerfile`, `docker-compose.yml`
- Check for `.github/workflows/` (CI/CD patterns)
- Check for `.eslintrc*`, `.prettierrc*`, `jest.config.*`, `vitest.config.*` (code quality tools)
- Examine `src/` directory structure to understand the project layout

### 1.2 Scan Existing Claude Configuration

- Read `CLAUDE.md` if it exists — note its full content and structure
- List `.claude/` directory if it exists
- Read ALL files in `.claude/agents/` — note each agent's name, model, tools, skills, and system prompt
- Read ALL files in `.claude/commands/` — note each command's routing
- Read ALL files in `.claude/guides/` — note what topics they cover
- Check `strategy/` at the project root — note what exists (foundation, research, etc.)
- Check `.claude/strategy/` — detect if strategy is in the old location
- Check `.claude/plans/` — note any existing plans

### 1.3 Understand Project Context

- Read `README.md` if it exists — extract project description, purpose, audience
- Read `DESIGN_SYSTEM.md` or similar design docs if they exist
- Examine key source directories to understand architecture patterns

### 1.4 Auto-Detect Workspace Scope Tier

Based on the scan results, determine the suggested installation tier:

- **Has eng-\* agents or code source files, but NO product/design/strategy agents** → suggest **Tier 1: Coding only**
- **Has eng-\* agents or code files AND product/design agents (product-manager, design-ux, etc.)** → suggest **Tier 2: Coding + Product & Design**
- **Has code + product agents AND strategy/writing/marketing agents** → suggest **Tier 3: Full stack**
- **Has product/design/strategy agents but NO eng-\* agents and NO code source files** → suggest **Tier 4: Product & Strategy only**

If ambiguous (e.g., code files exist but no agents at all), default to suggesting Tier 1 and let the user choose.

## Phase 2: Role Mapping and Questions

### 2.1 Map Existing Agents to ai-org Roles

This is critical. For each existing agent, determine which ai-org role it covers by reading its system prompt and description. Build a role mapping table:

| ai-org Role | Existing Agent | Confidence | Notes |
|-------------|---------------|------------|-------|
| eng-frontend | nextjs-developer | high | Both handle frontend component implementation |
| writer-content | content-writer | high | Both write articles and blog posts |
| eng-security | security-auditor | high | Both do security analysis |
| eng-testing | test-engineer | high | Both handle test strategy and writing |
| compliance | compliance-regulator | high | Both handle regulatory compliance |
| eng-devops | — | — | No existing agent covers this role |

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
```

Then present the suggested tier:

```
### Suggested Workspace Scope

Based on your project, we suggest **{tier name}**: {tier description}.

Reason: {explain what was detected that led to this suggestion}
```

Then ask:
1. Is the role mapping correct? Should any mappings be changed?
2. **Workspace scope** — is the suggested tier correct? (present all 4 options):
   - **Coding only** — engineering agents, code review, technical docs
   - **Coding + Product & Design** — adds PRDs, UX research, UI specs, design system
   - **Full stack** — adds strategy, positioning, content writing, marketing, compliance
   - **Product & Strategy only** — no coding agents; only product, design, strategy, and writing
3. Do you want agents created for the uncovered roles within the chosen tier?

The confirmed tier controls which uncovered roles get offered for creation. Do NOT offer to create agents outside the chosen tier scope (e.g., don't offer eng-frontend for Tier 4, don't offer strategist for Tier 1).

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
- A backup will be created before any modification
- Do NOT change the agent's name, model, tools, or system prompt — only add skills references

**ENHANCE CLAUDE.md** (if exists):
- Append ai-org sections below a `<!-- ai-org enhanced sections below -->` delimiter
- Add: Agent Reference table that lists BOTH existing agents AND new agents, with their role mapping
- Add: Model Tiers, Skill Isolation sections
- Do NOT modify any existing content above the delimiter

**CREATE** — New files only for UNCOVERED roles within the chosen tier:
- Only create new ai-org agents for roles that NO existing agent covers AND that fall within the user's chosen workspace scope tier
- Use the same tier-to-agent mapping as `/onboard` (see onboard.md section 4.3 for the full mapping per tier)
- New agents get project-specific system prompts based on scan results
- Each new agent's prompt includes: "Always read CLAUDE.md for project conventions before starting work."
- List each file and its purpose

**UPDATE ORCHESTRATOR** — Critical step:
- If the project has an existing orchestrator agent, ENHANCE it by adding a role mapping section to its system prompt that maps both existing AND ai-org agent names:
  ```
  ## Agent Routing (this project)
  - Frontend work → {existing-agent-name} (project agent)
  - Backend work → eng-backend (ai-org agent)
  - Content writing → {existing-agent-name} (project agent)
  - ...
  ```
- If no existing orchestrator, CREATE one with the full role mapping
- This ensures the orchestrator routes to the RIGHT agent regardless of naming convention

Present the full plan and ask: "Proceed with this migration plan?"

## Phase 4: Execute Migration

Only proceed after user confirms.

### 4.1 Create Backup

Create `.claude/backup/{ISO-date-timestamp}/` containing an exact copy of every file that will be modified (ENHANCE category only). Do NOT back up files that are only being created.

### 4.2 Enhance Existing Agents

For each existing agent that maps to an ai-org role:
- Add `skills:` field to frontmatter if missing, mapping to the appropriate ai-org skill domains:
  - Frontend agent → skills: [typescript, css-architecture, i18n] + the detected framework skill (angular OR javascript, not both)
  - Backend agent → skills: [database-design, i18n] + the detected language skill (java OR typescript, not both)
  - Content agent → skills: [content-strategy]
  - Security agent → skills: [security]
  - Testing agent → skills: [testing-strategy]
  - (Map each based on the role mapping from Phase 2)
- Ensure frontmatter has all required fields: name, description, model, tools
- Do NOT change the system prompt, name, model, or tools
- Do NOT rename the agent file

### 4.3 Enhance CLAUDE.md

**If exists**: Append below existing content after `<!-- ai-org enhanced sections below -->`:
- Agent Reference table listing ALL agents (existing + new) with their role
- Note which agents are project-original and which are ai-org additions
- Model Tiers, Skill Isolation sections

**If not exists**: Create from scratch using detected tech stack and project context from README.

### 4.4 Create or Update Orchestrator

This is the KEY step that makes existing and new agents work together.

The orchestrator's delegation decision tree must reference the ACTUAL agent names in this project:

```
## Delegation (project-specific routing)
1. Frontend/UI work → {actual agent name for frontend in this project}
2. Backend/API work → {actual agent name or ai-org agent if new}
3. Content writing → {actual agent name for content in this project}
...
```

Use existing agent names where they exist. Use ai-org agent names only for newly created agents.

### 4.5 Create Missing Agents

For uncovered roles only (roles where NO existing agent was mapped) AND within the chosen tier:
- Only create agents that belong to the user's confirmed workspace scope tier (see `/onboard` section 4.3 for tier-to-agent mapping)
- For Tier 1: do NOT create strategist, positioning, researcher, writer-content, writer-marketing, writer-ux, reviewer-content, compliance, or product/design agents
- For Tier 2: do NOT create strategist, positioning, researcher, writer-content, writer-marketing, reviewer-content, or compliance
- For Tier 4: do NOT create any eng-\* agents, reviewer-code, or reviewer-architecture
- Use ai-org frontmatter (name, model, tools, skills)
- Write project-specific system prompts using information from the scan
- Each new agent includes: "Always read CLAUDE.md for project conventions before starting work."
- Reference the actual project name, tech stack, and conventions detected

### 4.6 Create Missing Structure

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
Generate project-level commands that route to the project's agents (using actual agent names from the role mapping). Use the same tier-gated command rules as `/onboard` section 4.7:
- Core commands (plan, build, feature, review, docs, changelog, status) — all tiers
- Coding commands (test, component, api, db-migrate, refactor, perf, adr) — Tiers 1, 2, 3 only
- Product commands (prd) — Tiers 2, 3, 4 only
- Strategy commands (position, research) — Tiers 3 and 4 only
- Content/marketing/compliance commands (article, copywrite, audit) — Tiers 3 and 4 only
Each command includes project-specific context (detected tech stack, project name from README). Read the corresponding ai-org plugin command files and adapt their workflows to reference the project's specifics.

**Directories** (if missing):
- `.claude/plans/`

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
| writer-content | {name} | existing (enhanced with skills) |
| ... | ... | ... |

### Preserved (existing files, untouched)
- {each file with reason}

### Enhanced (existing files, skills added)
- {each agent} → added skills: [{skills}], backup at {path}

### CLAUDE.md
- {enhanced with ai-org sections / created from scratch} → backup at {path}

### Orchestrator
- {updated routing to map all agents / created new}

### Commands Generated
- {count} project commands created in .claude/commands/
- {list each command and which agent it routes to}

### Created (new files)
- {each file with purpose}

### Backed Up
- All backups in: .claude/backup/{timestamp}/

### Folder Restructuring
- Strategy location: {strategy/ at root / moved from .claude/strategy/ to strategy/ / created new}

### Next Steps
- Review the orchestrator's routing table — ensure it maps to the right agents
- Review enhanced CLAUDE.md — merge ai-org sections as needed
- Review skills added to existing agents — verify they are appropriate
- (Tiers 2, 3, 4 only) Fill in strategy templates if not already done
```

## Rules

- NEVER delete existing files
- NEVER overwrite existing files without creating a backup first
- NEVER modify existing system prompt content in agent files (only add/fix frontmatter) — **exception**: the orchestrator's system prompt may have an agent routing section added (see UPDATE ORCHESTRATOR in Phase 3)
- NEVER create a new agent for a role already covered by an existing agent
- NEVER rename existing agent files
- Always preserve existing content when enhancing files
- Detect tech stack automatically — do not ask the user to specify what is detectable
- Use detected project patterns in generated agents
- Map existing agents to ai-org roles by reading their system prompts, not by name matching
- The orchestrator MUST know about ALL agents (existing + new) by their actual names
- Ask for user confirmation before executing the migration plan
- If the project already has a complete ai-org setup, report "already migrated" and suggest manual customization
