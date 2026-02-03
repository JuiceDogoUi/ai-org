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
   - Mobile app — iOS native (Swift/SwiftUI)
   - Mobile app — Android native (Kotlin/Jetpack Compose)
   - Mobile app — Cross-platform (React Native)
   - Mobile app — Cross-platform (Flutter)
   - Desktop app — Electron
   - Desktop app — Tauri
   - Desktop app — Native (Swift/AppKit, C#/WPF, etc.)
   - API / Backend service (no frontend)
   - Monorepo (multiple apps/packages)
   - Documentation / Strategy repo (no code — product docs, strategy, content)

If the user chose "Documentation / Strategy repo", note that this typically pairs with **Product & Strategy only** (Tier 4) in question 10. If the user selects a coding tier (Tier 1, 2, or 3) with this project type, warn them that no tech stack was collected and coding agents will have no stack context — confirm they want to proceed.

## Phase 2: Gather Tech Stack

**Skip this entire phase if the user chose "Documentation / Strategy repo"** — there is no tech stack to gather. Proceed directly to Phase 3.

Ask ONLY the questions relevant to the project type chosen above. Skip irrelevant questions. If a choice implies the language (e.g., Next.js implies TypeScript, Spring Boot implies Java, SwiftUI implies Swift, Kotlin implies Android, Flutter implies Dart), do NOT ask the language question — infer it.

**Question numbering**: Questions are numbered with prefixes by category (W = Web, M = Mobile, D = Desktop, R = Monorepo) to avoid confusion. Only ask questions relevant to the chosen project type.

### Web Projects (Full-stack, SPA, Website)

W1. **Frontend framework** (skip if API-only):
   - Angular
   - React (Next.js) — includes built-in API routes as backend
   - React (Vite) — frontend only, needs separate backend
   - React (Remix) — full-stack with loaders/actions
   - Vue (Nuxt) — includes server routes as backend
   - Vue (Vite) — frontend only, needs separate backend
   - Svelte (SvelteKit) — includes server routes as backend
   - Astro — content-focused with islands architecture
   - None / Other

W2. **Backend framework** (skip if website-only or if a full-stack framework was chosen):
   - Spring Boot (Java)
   - Express (Node.js)
   - NestJS (Node.js)
   - Fastify (Node.js)
   - Django (Python)
   - FastAPI (Python)
   - Flask (Python)
   - Gin (Go)
   - Echo (Go)
   - Rails (Ruby)
   - None / Other

   If the user chose a full-stack framework (Next.js, Nuxt, SvelteKit, or Remix) AND "Full-stack web app", the backend is included. Do NOT ask this question — note the framework's server routes as the backend.

W3. **CSS approach** (skip if no frontend):
   - Tailwind CSS
   - SCSS / SASS
   - CSS Modules
   - Styled Components
   - Emotion
   - Plain CSS

W4. **Database** (skip if no backend):
   - PostgreSQL
   - MySQL
   - MongoDB
   - SQLite
   - Redis (as primary store)
   - DynamoDB
   - Firestore
   - None yet

### Mobile Projects

For **iOS native**: Infer Swift/SwiftUI. No additional questions — skip to Phase 3.

For **Android native**: Infer Kotlin/Jetpack Compose. No additional questions — skip to Phase 3.

For **React Native**:

M1. **State management**:
   - Redux Toolkit
   - Zustand
   - React Context only
   - Other

M2. **Navigation library**:
   - React Navigation
   - Expo Router
   - Other

For **Flutter**:

M3. **State management**:
   - Provider
   - Riverpod
   - BLoC
   - GetX
   - Other

### Desktop Projects

For **Electron**:

D1. **Frontend framework for renderer**:
   - React
   - Vue
   - Svelte
   - Vanilla TypeScript

For **Tauri**:

D2. **Frontend framework**:
   - React
   - Vue
   - Svelte
   - SolidJS
   - Vanilla TypeScript

For **Native desktop**:

D3. **Target platform**:
   - macOS (Swift/AppKit or SwiftUI)
   - Windows (C#/WPF or WinUI)
   - Linux (GTK/Qt)
   - Cross-platform (Qt, Avalonia)

### Monorepo Projects

R1. **Monorepo tool**:
   - Turborepo
   - Nx
   - Lerna
   - pnpm workspaces
   - npm/yarn workspaces
   - None / Other

R2. **Primary app type** (the main app in the monorepo):
   - Web app (then ask the W1-W4 questions for that app)
   - Mobile app (then ask the M1-M3 questions for that platform)
   - Multiple app types (ask relevant questions for each app type)

**Monorepo skill aggregation**: For monorepos with multiple apps, scan each app directory and apply the skill-to-stack mapping per app. Aggregate all skills across apps into a single installed skills list. Example: A monorepo with a Next.js web app and a React Native mobile app would install: react, typescript, javascript, css-architecture, accessibility, i18n, testing-strategy, security, performance.

## Phase 3: Gather Organization Context

8. **Business context**: What is the product? Who is the target audience? What industry? (one paragraph is fine)
9. **Team size**: Solo developer, small team (2-5), or larger team (6+)?
10. **Workspace scope** (pick one):
    - **Tier 1 (Coding only)** — engineering agents, code review, technical docs (app repo where product/strategy lives elsewhere)
    - **Tier 2 (Coding + Product & Design)** — adds PRDs, UX research, UI specs, design system (repo that needs product specs alongside code)
    - **Tier 3 (Full stack)** — adds strategy, positioning, content writing, marketing, compliance (everything lives together)
    - **Tier 4 (Product & Strategy only)** — no coding agents; only product, design, strategy, and writing (doc management or strategy repo)

## Phase 3.5: Confirm Before Proceeding

Before generating any files, present a summary of all gathered information and ask for confirmation:

```
## Summary

**Project**: {name} — {description}
**Type**: {project type}
**Tech Stack**: {framework}, {language}, {CSS approach}, {database} (or "N/A" for Tier 4)
**Business Context**: {context summary}
**Team Size**: {size}
**Workspace Scope**: {tier name}

**Agents to create**: {count} ({list names})
**Commands to create**: {count}
**Skills to install**: {list}

Does this look correct? (yes / make changes)
```

Wait for confirmation before proceeding. If the user wants changes, ask which specific item to change and update accordingly.

## Phase 4: Generate Project Structure

After ALL answers are collected, generate the following. Use the workspace scope tier from question 10 to determine which agents, commands, guides, and strategy files to install. Check if `package.json` or other project files already exist — if so, SKIP the project scaffold (section 4.8) and tell the user you detected an existing project and only generated the `.claude/` structure. Warn if any `.claude/` files already exist and ask before overwriting.

### 4.1 Determine Skills to Install

Based on the detected tech stack, determine which skills are relevant. **Only install skills that match the project's actual stack.**

#### Skill-to-Stack Mapping

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

#### Universal Skills (always install for coding tiers)

- i18n (internationalization)
- testing-strategy
- security
- performance

**Accessibility skill assignment**: The `accessibility` skill is installed for any project with a UI (web, mobile, desktop). Assign it to: eng-frontend, eng-styles, and design-lead (if present). Do NOT create a separate accessibility agent — accessibility is integrated into frontend and design workflows.

#### Product/Strategy Skills (Tiers 2, 3, 4)

- product-management, product-analytics
- positioning, research-methodology, competitive-analysis
- content-strategy, ux-writing, marketing-copy, technical-writing
- compliance-frameworks, review-process

Record the list of skills to install — agents will only reference skills from this list.

### 4.2 Copy Skills to Project

Copy the skill directories determined in section 4.1 from the ai-org plugin's `skills/` directory to the project's `.claude/skills/` directory.

For each skill to install:
1. Read the entire skill directory from ai-org (e.g., `ai-org/skills/typescript/`)
2. Copy to `.claude/skills/{skill-name}/` in the project
3. Include all files: `SKILL.md` and any supporting docs (patterns.md, etc.)

This allows users to:
- Customize skills for their project's specific conventions
- Update skills independently of the plugin
- Add project-specific patterns and examples

**Directory structure created:**
```
.claude/
├── agents/          # Project-specific agents
├── guides/          # Project guides
└── skills/          # Copied and customizable skills
    ├── typescript/
    │   ├── SKILL.md
    │   ├── patterns.md
    │   └── tsconfig-guide.md
    ├── react/
    │   └── SKILL.md
    └── ...
```

### 4.3 Read the ai-org base agents

Before generating project agents, read the corresponding ai-org base agent files from the plugin's `agents/` directory to use as templates. Copy their frontmatter (name, model, tools) and **filter the skills list to only include skills that are being installed** (from section 4.1). Then rewrite the system prompt to be project-specific.

### 4.4 Project CLAUDE.md

Create `CLAUDE.md` at the project root. This is the operational playbook that every agent reads first.

Content:
- **Project name and description** (from Phase 1)
- **Tech stack table** (from Phase 2) — omit for Tier 4 / Documentation repos where Phase 2 was skipped
- **Installed skills** (from section 4.1) — list only the skills that were installed
- **Commands section** (Tiers 1, 2, 3 only) with actual dev/build/test/lint commands for the chosen stack:
  - Next.js: `npm run dev`, `npm run build`, `npm test`, `npm run lint`
  - Angular: `ng serve`, `ng build`, `ng test`, `ng lint`
  - Spring Boot: `./gradlew bootRun`, `./gradlew build`, `./gradlew test`
  - Django: `python manage.py runserver`, `python manage.py test`, `python manage.py check`
  - FastAPI/Flask: `uvicorn main:app --reload` or `flask run`, `pytest`
  - Go: `go run .`, `go build`, `go test ./...`
  - Swift/iOS: `swift build`, `swift test`, or Xcode build commands
  - Kotlin/Android: `./gradlew assembleDebug`, `./gradlew test`, `./gradlew lint`
  - React Native: `npm start`, `npm run ios`, `npm run android`, `npm test`
  - Flutter: `flutter run`, `flutter build`, `flutter test`
  - Electron: `npm run dev`, `npm run build`, `npm run package`
  - Tauri: `npm run tauri dev`, `npm run tauri build`
  - Populate for any stack chosen.
  - For Tier 4: replace with a **Workflows section** listing available slash commands (`/prd`, `/position`, `/research`, `/article`, etc.) instead of dev commands
- **Project structure** section describing the directory layout:
  - `.claude/` — Claude Code configuration only (agents, commands, guides, plans)
  - `initiatives/` — Feature work with research, specs, and review reports (at project root)
  - `strategy/` — Product and research team documents: personas, positioning, competitive analysis, market research (at project root, Tiers 2, 3, 4 only)
  - Source code directories as appropriate for the stack
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

### 4.5 Project Agents

Create agents in `.claude/agents/`. Use the workspace scope tier and team size to determine which agents to create. **Only assign skills from the installed skills list (section 4.1).**

#### Tier 1 (Coding only)

**Core agents (always):**
- orchestrator.md, eng-architect.md, eng-testing.md, eng-security.md, reviewer-code.md, reviewer-architecture.md, writer-lead.md

**writer-lead scope for Tier 1**: In Tier 1, writer-lead handles only technical documentation (README, API docs, code comments, architecture docs). Assign only the `technical-writing` skill. Do NOT assign content-strategy, ux-writing, or marketing-copy skills — those are Tier 2+ only.

**Add for small team (2-5) or larger:**
- eng-devops.md, eng-performance.md

**Stack-conditional (based on project type):**
- eng-frontend.md, eng-styles.md — if project has frontend (web, mobile, or desktop)
- eng-backend.md, eng-api.md — if project has backend (eng-backend includes database work)

#### Tier 2 (Coding + Product & Design)

Everything from Tier 1, PLUS:
- product-lead.md, design-lead.md

**writer-lead scope for Tier 2+**: In Tier 2 and above, writer-lead gains full writing capabilities. Assign all applicable skills: technical-writing, content-strategy, ux-writing, marketing-copy.

#### Tier 3 (Full stack)

Everything from Tier 2, PLUS:
- positioning.md, researcher.md, reviewer-content.md, compliance.md

(Do NOT gate positioning/researcher on team size — include them for all Tier 3 projects regardless of team size.)

#### Tier 4 (Product & Strategy only)

**Core:**
- orchestrator.md, writer-lead.md

**Product & Design:**
- product-lead.md, design-lead.md

**Strategy:**
- positioning.md, researcher.md

**Review:**
- reviewer-content.md

**Compliance:**
- compliance.md

**NO eng-\* agents, NO reviewer-code, NO reviewer-architecture** — Tier 4 has no coding agents. Skip all stack-conditional agents.

When generating the orchestrator for Tier 4, adapt the delegation decision tree to focus on product and strategy routing. Replace the code-centric rules (items 2-12 in the base orchestrator) with:

1. Is it a full product workflow? → follow the /feature command workflow
2. Is it product requirements, user stories, or metrics? → product-lead
3. Is it UX/UI design or design system? → design-lead
4. Is it any writing task (docs, articles, marketing, UX copy)? → writer-lead
5. Is it business strategy or market analysis? → product-lead
6. Is it product positioning? → positioning
7. Is it research? → researcher
8. Is it compliance or regulatory? → compliance
9. Is it content review? → reviewer-content

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

### 4.6 Guides

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

### 4.7 Strategy Skeleton

**Skip this section entirely for Tier 1 (Coding only)** — coding-only repos don't need positioning or personas.

For Tiers 2, 3, and 4, create in `strategy/` (at the project root, NOT inside `.claude/`):

**`foundation/personas.md`** — Pre-populate the first persona slot using the business context answer from Phase 3. Use the target audience as the primary persona archetype, with sections for: demographics, pain points, current solutions, desires, and buying triggers. Leave two more persona slots as templates.

**`foundation/positioning.md`** — Pre-populate the target customer section using the business context answer. Structure follows the positioning skill's canvas template (see `skills/positioning/positioning-canvas.md`): competitive alternatives, unique attributes, value mapping, target customer characteristics, market category, relevant trends. Include the positioning statement template at the end.

**`research/competitors/.gitkeep`** and **`research/market/.gitkeep`**

### 4.8 Project Scaffold

**Skip this section entirely for Tier 4 (Product & Strategy only)** — no code scaffold for product-only repos.

**IMPORTANT: If `package.json`, `pom.xml`, `Package.swift`, `pubspec.yaml`, `Cargo.toml`, or any project config file already exists, SKIP this entire section.** Tell the user: "Detected existing project files — skipping scaffold. Only `.claude/` structure was generated."

If the project is truly empty, create directories and minimal config files:

| Stack | What to create |
|-------|---------------|
| Next.js | `src/app/`, `src/components/`, `src/lib/`, `public/`, `package.json`, `tsconfig.json`, `next.config.ts`, `.env.example`, `.gitignore` |
| Angular | `src/app/`, `src/environments/`, `src/assets/`, `angular.json`, `tsconfig.json`, `package.json`, `.gitignore` |
| React (Vite) | `src/`, `src/components/`, `src/hooks/`, `public/`, `vite.config.ts`, `package.json`, `tsconfig.json`, `.gitignore` |
| Spring Boot | `src/main/java/{pkg}/`, `src/main/resources/`, `src/test/java/{pkg}/`, `build.gradle.kts`, `.env.example`, `.gitignore` |
| Swift/iOS | `{ProjectName}/`, `{ProjectName}Tests/`, `{ProjectName}.xcodeproj/` or `Package.swift`, `.gitignore` |
| Kotlin/Android | `app/src/main/java/{pkg}/`, `app/src/main/res/`, `app/src/test/`, `build.gradle.kts`, `settings.gradle.kts`, `.gitignore` |
| React Native | `src/`, `src/screens/`, `src/components/`, `src/navigation/`, `package.json`, `tsconfig.json`, `app.json`, `.gitignore` |
| Flutter | `lib/`, `lib/screens/`, `lib/widgets/`, `test/`, `pubspec.yaml`, `.gitignore` |
| Electron | `src/main/`, `src/renderer/`, `src/preload/`, `package.json`, `tsconfig.json`, `.gitignore` |
| Tauri | `src/`, `src-tauri/`, `src-tauri/src/`, `package.json`, `tsconfig.json`, `src-tauri/Cargo.toml`, `src-tauri/tauri.conf.json`, `.gitignore` |
| Node API | `src/`, `src/routes/`, `src/services/`, `src/middleware/`, `package.json`, `tsconfig.json`, `.env.example`, `.gitignore` |
| Vue (Vite) | `src/`, `src/components/`, `src/composables/`, `public/`, `vite.config.ts`, `package.json`, `tsconfig.json`, `.gitignore` |
| Vue (Nuxt) | `app/`, `components/`, `composables/`, `pages/`, `server/`, `public/`, `nuxt.config.ts`, `package.json`, `tsconfig.json`, `.gitignore` |
| Svelte (SvelteKit) | `src/`, `src/routes/`, `src/lib/`, `static/`, `svelte.config.js`, `vite.config.ts`, `package.json`, `tsconfig.json`, `.gitignore` |
| Monorepo | `apps/`, `packages/`, `package.json` (workspace root), `turbo.json`, `.gitignore` |

Generate config files with sensible defaults. Include `.gitignore` with appropriate patterns for the stack (node_modules, .env, dist, .next, etc.). Include `.env.example` for database projects listing required variables. Do NOT generate application code — only structure and configuration.

### 4.9 Project Commands

Generate project-level commands in `.claude/commands/`. These commands include project-specific context (tech stack, conventions) and route to the project's agents. They shadow the plugin's generic commands with tailored versions.

Each command file has YAML frontmatter (name, description, argument-hint if applicable, context: fork, agent) followed by a brief prompt that includes project-specific context. The prompt should mention the project name, tech stack, and reference CLAUDE.md.

**Core commands (always generate, all tiers):**

| Command | Agent | Description |
|---------|-------|-------------|
| `plan.md` | orchestrator | Create an implementation plan for {project name} |
| `build.md` | orchestrator | Build a feature end-to-end (adapts behavior based on available agents) |
| `feature.md` | orchestrator | Full product workflow — understand, research, build, review (adapts behavior based on available agents) |
| `review.md` | orchestrator | 3-round review — functional, quality, compliance |
| `docs.md` | writer-lead | Generate documentation |
| `changelog.md` | orchestrator | Generate a changelog from recent commits |
| `status.md` | orchestrator | Generate project status report |

**Tiers 1, 2, 3 only (coding commands — skip for Tier 4):**

| Command | Agent | Description | Condition |
|---------|-------|-------------|-----------|
| `test.md` | eng-testing | Write tests using the project's test framework | Always for Tiers 1-3 |
| `component.md` | eng-frontend | Scaffold a UI component using {framework} | If project has frontend |
| `db-migrate.md` | eng-backend | Create a database migration for {database} | If project has database |
| `refactor.md` | orchestrator | Refactor code with pre and post review | Always for Tiers 1-3 |
| `perf.md` | eng-performance | Performance analysis and optimization | If eng-performance agent exists |
| `deploy.md` | eng-devops | Deployment workflow | If eng-devops agent exists |

**Tiers 2, 3, 4 only (product commands — skip for Tier 1):**

| Command | Agent | Description |
|---------|-------|-------------|
| `prd.md` | product-lead | Create a product requirements document |

**Tiers 3 and 4 only (strategy commands — positioning and researcher agents required):**

| Command | Agent | Description |
|---------|-------|-------------|
| `position.md` | positioning | Define or refine product positioning |
| `research.md` | researcher | Deep research on a topic |

**Tiers 1, 2, 3 only (security command):**

| Command | Agent | Description |
|---------|-------|-------------|
| `audit.md` | orchestrator | Security audit (Tier 1-2: security only; Tier 3: security + accessibility + compliance) |

**Tiers 3 and 4 only (content, marketing commands):**

| Command | Agent | Description |
|---------|-------|-------------|
| `article.md` | writer-lead | Write a blog post or article |
| `copywrite.md` | orchestrator | Marketing or UX copy |

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

### 4.10 Empty Directories

Create with `.gitkeep`:
- `.claude/plans/`
- `initiatives/`

### 4.11 Version File

Create `.claude/version.json`:
```json
{
  "aiOrgVersion": "1.0.0",
  "installedAt": "{ISO timestamp}",
  "createdWith": "onboard"
}
```

## Phase 5: Summary

After generating everything, present:
1. A tree view of all files created
2. The total number of agents, commands, and skills generated:
   - Agents: {count} — {list names}
   - Commands: {count} — {list names}
   - Skills: {count} copied to .claude/skills/ — {list names}
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
   - Customize skills in `.claude/skills/` to match your project's conventions
   - Add project-specific conventions to `CLAUDE.md` as you establish them
   - (Tiers 2, 3, 4 only) Flesh out personas in `strategy/foundation/personas.md` (first slot is pre-populated)
   - (Tiers 2, 3, 4 only) Complete positioning in `strategy/foundation/positioning.md`
