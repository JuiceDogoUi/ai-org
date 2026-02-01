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

## Phase 2: Gather Tech Stack

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
10. **Additional agents** (yes or no for each):
    - Do you need **content writing** agents? (blog posts, articles, SEO content)
    - Do you need **marketing** agents? (landing pages, email campaigns, ad copy)
    - Do you need **compliance and regulatory** agents? (GDPR, WCAG, license audits, industry regulations)
    - Do you need **product and design** agents? (adds 5 agents: PRDs, UX research, UI specs, design system, analytics)

## Phase 4: Generate Project Structure

After ALL answers are collected, generate the following. Check if `package.json` or other project files already exist — if so, SKIP the project scaffold (section 4.5) and tell the user you detected an existing project and only generated the `.claude/` structure. Warn if any `.claude/` files already exist and ask before overwriting.

### 4.1 Read the ai-org base agents

Before generating project agents, read the corresponding ai-org base agent files from the plugin's `agents/` directory to use as templates. Copy their frontmatter (name, model, tools, skills) exactly, then rewrite the system prompt to be project-specific.

### 4.2 Project CLAUDE.md

Create `CLAUDE.md` at the project root. This is the operational playbook that every agent reads first.

Content:
- **Project name and description** (from Phase 1)
- **Tech stack table** (from Phase 2)
- **Commands section** with actual dev/build/test/lint commands for the chosen stack:
  - Next.js: `npm run dev`, `npm run build`, `npm test`, `npm run lint`
  - Angular: `ng serve`, `ng build`, `ng test`, `ng lint`
  - Spring Boot: `./gradlew bootRun`, `./gradlew build`, `./gradlew test`
  - Swift: `swift run`, `swift build`, `swift test`
  - Populate for any stack chosen.
- **Project structure** section describing the directory layout (include `initiatives/` and `strategy/` at the project root)
- **Agent reference table** listing ALL generated agents with name, model, and one-line purpose
- **Interaction model**: commands route to agents, orchestrator handles multi-domain requests
- **Model tiers**: opus/sonnet/haiku
- **Skill isolation**: skills are knowledge, not identity
- **Business context** (paste the user's answer from Phase 3 question 8)
- **Project conventions** section with sensible defaults for the stack:
  - Commit format: Conventional Commits
  - Branching: trunk-based development (solo) or feature branches (team)
  - Code style: ESLint + Prettier (TypeScript/JS), Checkstyle (Java), SwiftLint (Swift)

### 4.3 Project Agents

Create agents in `.claude/agents/`. Scale to team size:

**Core agents (always, any team size):**
- orchestrator.md, eng-testing.md, eng-security.md, reviewer-code.md, writer-technical.md

**Add for small team (2-5) or larger:**
- eng-devops.md, eng-performance.md, reviewer-architecture.md, project-manager.md

**Add for larger team (6+):**
- researcher.md, strategist.md

**Add if project has frontend:**
- eng-frontend.md, eng-styles.md

**Add if project has backend:**
- eng-backend.md, eng-api.md

**Add if project has database:**
- eng-database.md

**Add if mobile project:**
- eng-mobile.md

**Add if desktop project:**
- eng-desktop.md

**Add if content writing = yes:**
- writer-content.md

**Add if marketing = yes:**
- writer-marketing.md, reviewer-content.md

**Add if content OR marketing = yes, AND has frontend:**
- writer-ux.md

**Add if compliance = yes:**
- compliance.md

**Add if product/design = yes:**
- product-manager.md, product-analyst.md, design-ux.md, design-ui.md, design-system.md

For EACH agent:
1. Read the corresponding ai-org base agent file from the plugin's `agents/` directory
2. Copy the YAML frontmatter exactly (same name, model, tools, skills)
3. Rewrite the system prompt to be project-specific:
   - Open with: "You are a senior {role} working on **{project name}**, {description}."
   - Mention the specific tech stack: "This project uses {framework} with {language} and {css approach}."
   - Include the business context and target audience
   - Add: "Always read `CLAUDE.md` for project conventions before starting work."
   - Add: "Read relevant files in `.claude/guides/` and `strategy/` for additional context."
4. Keep the same section structure: intro paragraph, ## Approach, ## Standards, ## What You Do NOT Do
5. Preserve read-only restrictions for security/performance/compliance/reviewer agents

### 4.4 Guides

Create in `.claude/guides/`:

**Always generate:**
- `development.md` — Local setup, environment variables, dev/build/test/lint commands. Include `.env.example` content listing required variables (e.g., `DATABASE_URL` for database projects). Populated with actual commands for the chosen stack.

**Generate for team (2+ developers):**
- `contributing.md` — Code style conventions, PR process template, commit message format. Populated from the stack's conventions.

**If project has backend/infrastructure:**
- `deployment.md` — Deployment checklist skeleton, environment config, health check verification.

**If content writing or marketing = yes:**
- `content-creation.md` — Content workflow with sections for: brand voice and tone guidelines, target personas (reference `strategy/foundation/personas.md`), SEO requirements, review process, publishing checklist.

### 4.5 Strategy Skeleton

Create in `strategy/` (at the project root, NOT inside `.claude/`):

**`foundation/personas.md`** — Pre-populate the first persona slot using the business context answer from Phase 3. Use the target audience as the primary persona archetype, with sections for: demographics, pain points, current solutions, desires, and buying triggers. Leave two more persona slots as templates.

**`foundation/positioning.md`** — Pre-populate the target customer section using the business context answer. Structure follows the positioning skill's canvas template (see `skills/positioning/positioning-canvas.md`): competitive alternatives, unique attributes, value mapping, target customer characteristics, market category, relevant trends. Include the positioning statement template at the end.

**`research/competitors/.gitkeep`** and **`research/market/.gitkeep`**

### 4.6 Project Scaffold

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

**Core commands (always generate):**

| Command | Agent | Description |
|---------|-------|-------------|
| `plan.md` | orchestrator | Create an implementation plan for {project name} |
| `build.md` | orchestrator | Build a feature end-to-end |
| `feature.md` | orchestrator | Full product workflow — understand, research, build, review |
| `review.md` | orchestrator | 3-round review — functional, quality, compliance |
| `test.md` | eng-testing | Write tests using the project's test framework |
| `docs.md` | writer-technical | Generate documentation |

**Add if project has frontend:**
| `component.md` | eng-frontend | Scaffold a UI component using {framework} |

**Add if project has backend:**
| `api.md` | eng-api | Design or build an API endpoint |

**Add if project has database:**
| `migration.md` | eng-database | Create a database migration for {database} |

**Add if content writing = yes:**
| `article.md` | writer-content | Write a blog post or article |

**Add if marketing = yes:**
| `copy.md` | orchestrator | Marketing or UX copy |

**Add if compliance = yes:**
| `audit.md` | orchestrator | Security and accessibility audit |

**Add if team size is small team or larger:**
| `sprint.md` | project-manager | Sprint planning |
| `estimate.md` | project-manager | Effort estimation |

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
3. How to start using the project:
   - "Run `{dev command}` to start the dev server"
   - "Use `/feature` to run the full product workflow (understand → research → build → review)"
   - "Use `/plan` to plan your first feature"
   - "Use `/build` to implement it"
   - "Use `/review` to review your code before committing"
4. Suggested next steps:
   - Flesh out personas in `strategy/foundation/personas.md` (first slot is pre-populated)
   - Complete positioning in `strategy/foundation/positioning.md`
   - Customize agent prompts in `.claude/agents/` as your project patterns emerge
   - Add project-specific conventions to `CLAUDE.md` as you establish them
