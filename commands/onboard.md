---
name: onboard
description: Set up a new project with personalized ai-org agents, guides, and structure
argument-hint: "[project name]"
context: fork
agent: orchestrator
---

Set up a new, empty project with a fully personalized ai-org structure. Project name (if provided): $ARGUMENTS

You MUST follow this workflow exactly. Do NOT skip phases or generate files before gathering all information.

## Phase 1: Gather Project Identity

Ask the user these questions. Wait for answers before proceeding.

1. **Project name** (use the argument if provided, otherwise ask)
2. **Project description**: What does this project do? (one sentence)
3. **Project type** (pick one):
   - Full-stack web app (SSR/SSG frontend + API backend, e.g., Next.js with database)
   - Single-page app with separate backend (SPA + REST/GraphQL API)
   - Website (static or SSR, content-focused, no backend logic)
   - Mobile app (iOS native)
   - Desktop app (Electron)
   - API / Backend service (no frontend)
   - Monorepo (multiple apps/packages)
   - Documentation / Strategy repo (no code — product docs, strategy, content)

If the user chose "Documentation / Strategy repo", note that this typically pairs with **Product & Strategy only** (Tier 4) in question 10. If the user selects a coding tier (Tier 1, 2, or 3) with this project type, warn them that no tech stack was collected and coding agents will have no stack context — confirm they want to proceed.

## Phase 2: Gather Tech Stack

**Skip this entire phase if the user chose "Documentation / Strategy repo"** — there is no tech stack to gather. Proceed directly to Phase 3.

Ask ONLY the questions relevant to the project type chosen above. Skip irrelevant questions. If a choice implies the language (e.g., Next.js implies TypeScript, Spring Boot implies Java, SwiftUI implies Swift), do NOT ask the language question — infer it.

4. **Frontend framework** (skip if API-only):
   - Angular
   - React (Next.js) — includes built-in API routes as backend
   - React (Vite) — frontend only, needs separate backend
   - Vue (Vite)
   - Svelte (SvelteKit)
   - None / Other

5. **Backend framework** (skip if website-only or if Next.js was chosen as full-stack):
   - Spring Boot (Java)
   - Express (Node.js)
   - NestJS (Node.js)
   - Fastify (Node.js)
   - None / Other

   If the user chose "React (Next.js)" AND "Full-stack web app", the backend is Next.js API routes/server actions. Do NOT ask this question — note "Next.js API routes" as the backend.

6. **CSS approach** (skip if no frontend):
   - Tailwind CSS
   - SCSS / SASS
   - CSS Modules
   - Styled Components
   - Plain CSS

7. **Database** (skip if no backend):
   - PostgreSQL
   - MySQL
   - MongoDB
   - SQLite
   - None yet

## Phase 3: Gather Organization Context

8. **Business context**: What is the product? Who is the target audience? What industry? (one paragraph is fine)
9. **Team size**: Solo developer, small team (2-5), or larger team (6+)?
10. **Workspace scope** (pick one):
    - **Coding only** — engineering agents, code review, technical docs (app repo where product/strategy lives elsewhere)
    - **Coding + Product & Design** — adds PRDs, UX research, UI specs, design system (repo that needs product specs alongside code)
    - **Full stack** — adds strategy, positioning, content writing, marketing, compliance (everything lives together)
    - **Product & Strategy only** — no coding agents; only product, design, strategy, and writing (doc management or strategy repo)

## Phase 4: Generate Project Structure

After ALL answers are collected, generate the following. Use the workspace scope tier from question 10 to determine which agents, commands, guides, and strategy files to install. Check if `package.json` or other project files already exist — if so, SKIP the project scaffold (section 4.6) and tell the user you detected an existing project and only generated the `.claude/` structure. Warn if any `.claude/` files already exist and ask before overwriting.

### 4.1 Read the ai-org base agents

Before generating project agents, read the corresponding ai-org base agent files from the plugin's `agents/` directory to use as templates. Copy their frontmatter (name, model, tools, skills) exactly, then rewrite the system prompt to be project-specific.

### 4.2 Project CLAUDE.md

Create `CLAUDE.md` at the project root. This is the operational playbook that every agent reads first.

Content:
- **Project name and description** (from Phase 1)
- **Tech stack table** (from Phase 2) — omit for Tier 4 / Documentation repos where Phase 2 was skipped
- **Commands section** (Tiers 1, 2, 3 only) with actual dev/build/test/lint commands for the chosen stack:
  - Next.js: `npm run dev`, `npm run build`, `npm test`, `npm run lint`
  - Angular: `ng serve`, `ng build`, `ng test`, `ng lint`
  - Spring Boot: `./gradlew bootRun`, `./gradlew build`, `./gradlew test`
  - Swift: `swift run`, `swift build`, `swift test`
  - Populate for any stack chosen.
  - For Tier 4: replace with a **Workflows section** listing available slash commands (`/prd`, `/position`, `/research`, `/article`, etc.) instead of dev commands
- **Project structure** section describing the directory layout (include `initiatives/` at the project root; include `strategy/` for Tiers 2, 3, and 4 only)
- **Agent reference table** listing ALL generated agents with name, model, and one-line purpose
- **Interaction model**: commands route to agents, orchestrator handles multi-domain requests
- **Model tiers**: opus/sonnet/haiku
- **Skill isolation**: skills are knowledge, not identity
- **Business context** (paste the user's answer from Phase 3 question 8)
- **Project conventions** section with sensible defaults:
  - Commit format: Conventional Commits
  - Branching: trunk-based development (solo) or feature branches (team)
  - (Tiers 1, 2, 3 only) Code style: ESLint + Prettier (TypeScript/JS), Checkstyle (Java), SwiftLint (Swift)
  - (Tier 4 only) Document conventions: file naming, review workflow, publishing checklist

### 4.3 Project Agents

Create agents in `.claude/agents/`. Use the workspace scope tier and team size to determine which agents to create.

#### Tier 1: Coding only

**Core agents (always):**
- orchestrator.md, eng-testing.md, eng-security.md, reviewer-code.md, writer-technical.md

**Add for small team (2-5) or larger:**
- eng-devops.md, eng-performance.md, reviewer-architecture.md, project-manager.md

**Stack-conditional (based on project type):**
- eng-frontend.md, eng-styles.md — if project has frontend
- eng-backend.md, eng-api.md — if project has backend
- eng-database.md — if project has database
- eng-mobile.md — if mobile project
- eng-desktop.md — if desktop project

#### Tier 2: Coding + Product & Design

Everything from Tier 1, PLUS:
- product-manager.md, product-analyst.md, design-ux.md, design-ui.md, design-system.md, writer-ux.md

#### Tier 3: Full stack

Everything from Tier 2, PLUS:
- strategist.md, positioning.md, researcher.md, writer-content.md, writer-marketing.md, reviewer-content.md, compliance.md

(Do NOT gate strategist/researcher on team size — include them for all Tier 3 projects regardless of team size.)

#### Tier 4: Product & Strategy only

**Core:**
- orchestrator.md, project-manager.md, writer-technical.md

**Product & Design:**
- product-manager.md, product-analyst.md, design-ux.md, design-ui.md, design-system.md

**Strategy:**
- strategist.md, positioning.md, researcher.md

**Writing & Marketing:**
- writer-content.md, writer-marketing.md, writer-ux.md, reviewer-content.md

**Compliance:**
- compliance.md

**NO eng-\* agents, NO reviewer-code, NO reviewer-architecture** — Tier 4 has no coding agents. Skip all stack-conditional agents.

When generating the orchestrator for Tier 4, adapt the delegation decision tree to focus on product and strategy routing. Replace the code-centric rules (items 2-12 in the base orchestrator) with:

1. Is it a full product workflow? → follow the /feature command workflow
2. Is it product requirements or user stories? → product-manager
3. Is it data analysis or metrics? → product-analyst
4. Is it UX flows or usability? → design-ux
5. Is it UI specs or visual design? → design-ui
6. Is it design system or tokens? → design-system
7. Is it technical documentation? → writer-technical
8. Is it articles or blog posts? → writer-content
9. Is it microcopy or UI text? → writer-ux
10. Is it marketing copy or landing pages? → writer-marketing
11. Is it business strategy or market analysis? → strategist
12. Is it product positioning? → positioning
13. Is it research? → researcher
14. Is it compliance or regulatory? → compliance
15. Is it project planning or sprints? → project-manager
16. Is it content review? → reviewer-content

For EACH agent:
1. Read the corresponding ai-org base agent file from the plugin's `agents/` directory
2. Copy and adapt the YAML frontmatter (same name, model, tools, skills — add project-relevant skills if the base agent's skill list is incomplete for this project's needs)
3. Rewrite the system prompt to be project-specific:
   - Open with: "You are a senior {role} working on **{project name}**, {description}."
   - (Tiers 1, 2, 3 only) Mention the specific tech stack: "This project uses {framework} with {language} and {css approach}."
   - Include the business context and target audience
   - Add: "Always read `CLAUDE.md` for project conventions before starting work."
   - (Tiers 2, 3, 4 only) Add: "Read relevant files in `.claude/guides/` and `strategy/` for additional context."
   - (Tier 1 only) Add: "Read relevant files in `.claude/guides/` for additional context."
4. Keep the same section structure: intro paragraph, ## Approach, ## Standards, ## What You Do NOT Do
5. Preserve read-only restrictions for security/performance/compliance/reviewer agents

### 4.4 Guides

Create in `.claude/guides/`:

**Generate for Tiers 1, 2, 3 (code projects):**
- `development.md` — Local setup, environment variables, dev/build/test/lint commands. Include `.env.example` content listing required variables (e.g., `DATABASE_URL` for database projects). Populated with actual commands for the chosen stack.

**Generate for Tier 4 (documentation/strategy repos):**
- `development.md` — Document workflow overview, tool setup (if any), folder structure conventions, and available slash commands for content creation and review.

**Generate for team (2+ developers):**
- `contributing.md` — For Tiers 1-3: code style conventions, PR process template, commit message format. Populated from the stack's conventions. For Tier 4: document style conventions, naming rules, PR process template, commit message format.

**If project has backend/infrastructure:**
- `deployment.md` — Deployment checklist skeleton, environment config, health check verification.

**If workspace scope is Tier 3 (Full stack) or Tier 4 (Product & Strategy only):**
- `content-creation.md` — Content workflow with sections for: brand voice and tone guidelines, target personas (reference `strategy/foundation/personas.md`), SEO requirements, review process, publishing checklist.

### 4.5 Strategy Skeleton

**Skip this section entirely for Tier 1 (Coding only)** — coding-only repos don't need positioning or personas.

For Tiers 2, 3, and 4, create in `strategy/` (at the project root, NOT inside `.claude/`):

**`foundation/personas.md`** — Pre-populate the first persona slot using the business context answer from Phase 3. Use the target audience as the primary persona archetype, with sections for: demographics, pain points, current solutions, desires, and buying triggers. Leave two more persona slots as templates.

**`foundation/positioning.md`** — Pre-populate the target customer section using the business context answer. Structure follows the positioning skill's canvas template (see `skills/positioning/positioning-canvas.md`): competitive alternatives, unique attributes, value mapping, target customer characteristics, market category, relevant trends. Include the positioning statement template at the end.

**`research/competitors/.gitkeep`** and **`research/market/.gitkeep`**

### 4.6 Project Scaffold

**Skip this section entirely for Tier 4 (Product & Strategy only)** — no code scaffold for product-only repos.

**IMPORTANT: If `package.json`, `pom.xml`, `Package.swift`, or any project config file already exists, SKIP this entire section.** Tell the user: "Detected existing project files — skipping scaffold. Only `.claude/` structure was generated."

If the project is truly empty, create directories and minimal config files:

| Stack | What to create |
|-------|---------------|
| Next.js | `src/app/`, `src/components/`, `src/lib/`, `public/`, `package.json`, `tsconfig.json`, `next.config.ts`, `.env.example`, `.gitignore` |
| Angular | `src/app/`, `src/environments/`, `src/assets/`, `angular.json`, `tsconfig.json`, `package.json`, `.gitignore` |
| React (Vite) | `src/`, `src/components/`, `src/hooks/`, `public/`, `vite.config.ts`, `package.json`, `tsconfig.json`, `.gitignore` |
| Spring Boot | `src/main/java/{pkg}/`, `src/main/resources/`, `src/test/java/{pkg}/`, `build.gradle.kts`, `.env.example`, `.gitignore` |
| Swift/iOS | `Sources/{ProjectName}/`, `Tests/{ProjectName}Tests/`, `Package.swift`, `.gitignore` |
| Electron | `src/main/`, `src/renderer/`, `src/preload/`, `package.json`, `tsconfig.json`, `.gitignore` |
| Node API | `src/`, `src/routes/`, `src/services/`, `src/middleware/`, `package.json`, `tsconfig.json`, `.env.example`, `.gitignore` |
| Vue (Vite) | `src/`, `src/components/`, `src/composables/`, `public/`, `vite.config.ts`, `package.json`, `tsconfig.json`, `.gitignore` |
| Svelte (SvelteKit) | `src/`, `src/routes/`, `src/lib/`, `static/`, `svelte.config.js`, `vite.config.ts`, `package.json`, `tsconfig.json`, `.gitignore` |
| Monorepo | `apps/`, `packages/`, `package.json` (workspace root), `turbo.json`, `.gitignore` |

Generate config files with sensible defaults. Include `.gitignore` with appropriate patterns for the stack (node_modules, .env, dist, .next, etc.). Include `.env.example` for database projects listing required variables. Do NOT generate application code — only structure and configuration.

### 4.7 Project Commands

Generate project-level commands in `.claude/commands/`. These commands include project-specific context (tech stack, conventions) and route to the project's agents. They shadow the plugin's generic commands with tailored versions.

Each command file has YAML frontmatter (name, description, argument-hint if applicable, context: fork, agent) followed by a brief prompt that includes project-specific context. The prompt should mention the project name, tech stack, and reference CLAUDE.md.

**Core commands (always generate, all tiers):**

| Command | Agent | Description |
|---------|-------|-------------|
| `plan.md` | orchestrator | Create an implementation plan for {project name} |
| `build.md` | orchestrator | Build a feature end-to-end (adapts behavior based on available agents) |
| `feature.md` | orchestrator | Full product workflow — understand, research, build, review (adapts behavior based on available agents) |
| `review.md` | orchestrator | 3-round review — functional, quality, compliance |
| `docs.md` | writer-technical | Generate documentation |
| `changelog.md` | orchestrator | Generate a changelog from recent commits |
| `status.md` | orchestrator | Generate project status report |

**Add if team size is small team or larger:**
| `estimate.md` | project-manager | Effort estimation |
| `sprint.md` | project-manager | Sprint planning for {project name} |

**Tiers 1, 2, 3 only (coding commands — skip for Tier 4):**

| Command | Agent | Description | Condition |
|---------|-------|-------------|-----------|
| `test.md` | eng-testing | Write tests using the project's test framework | Always for Tiers 1-3 |
| `component.md` | eng-frontend | Scaffold a UI component using {framework} | If project has frontend |
| `api.md` | eng-api | Design or build an API endpoint | If project has backend |
| `db-migrate.md` | eng-database | Create a database migration for {database} | If project has database |
| `refactor.md` | orchestrator | Refactor code with pre and post review | Always for Tiers 1-3 |
| `perf.md` | eng-performance | Performance analysis and optimization | If eng-performance agent exists |
| `adr.md` | orchestrator | Create an Architecture Decision Record | If reviewer-architecture agent exists |
| `deploy.md` | eng-devops | Deployment workflow | If eng-devops agent exists |

**Tiers 2, 3, 4 only (product commands — skip for Tier 1):**

| Command | Agent | Description |
|---------|-------|-------------|
| `prd.md` | product-manager | Create a product requirements document |

**Tiers 3 and 4 only (strategy commands — positioning and researcher agents required):**

| Command | Agent | Description |
|---------|-------|-------------|
| `position.md` | positioning | Define or refine product positioning |
| `research.md` | researcher | Deep research on a topic |

**Tiers 3 and 4 only (content, marketing, compliance commands):**

| Command | Agent | Description |
|---------|-------|-------------|
| `article.md` | writer-content | Write a blog post or article |
| `copywrite.md` | orchestrator | Marketing or UX copy |
| `audit.md` | orchestrator | Security and accessibility audit |

Each command prompt should follow this template:

```
---
name: {command-name}
description: {description tailored to project}
argument-hint: "{appropriate hint}"
context: fork
agent: {agent-name}
---

{Action} for **{project name}** ({project description}).

Tech stack: {framework}, {language}, {css approach}, {database}.
(Omit the Tech stack line for Tier 4 — replace with: "This is a documentation/strategy project. See CLAUDE.md for workflows and available agents.")

Read `CLAUDE.md` for project conventions before starting.

{Command-specific instructions from the corresponding ai-org plugin command — copy the workflow/phases relevant to this command, but replace generic references with project-specific details.}
```

For the command-specific instructions, read the corresponding command file from the ai-org plugin's `commands/` directory and adapt its workflow to reference the project's tech stack and conventions.

### 4.8 Empty Directories

Create with `.gitkeep`:
- `.claude/plans/`

## Phase 5: Summary

After generating everything, present:
1. A tree view of all files created
2. The total number of agents and commands generated, listing their names
3. How to start using the project (adapt to tier):
   - (Tiers 1, 2, 3 only) "Run `{dev command}` to start the dev server"
   - "Use `/feature` to run the full product workflow (understand → research → build → review)"
   - "Use `/plan` to plan your first feature"
   - (Tiers 1, 2, 3 only) "Use `/build` to implement it"
   - (Tiers 1, 2, 3 only) "Use `/review` to review your code before committing"
   - (Tiers 2, 3, 4 only) "Use `/prd` to draft a product requirements document"
   - (Tiers 3, 4 only) "Use `/position` to define your product positioning"
4. Suggested next steps:
   - Customize agent prompts in `.claude/agents/` as your project patterns emerge
   - Add project-specific conventions to `CLAUDE.md` as you establish them
   - (Tiers 2, 3, 4 only) Flesh out personas in `strategy/foundation/personas.md` (first slot is pre-populated)
   - (Tiers 2, 3, 4 only) Complete positioning in `strategy/foundation/positioning.md`
