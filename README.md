# ai-org

A reusable AI organization plugin for Claude Code. Provides **18 specialist agents**, **13 commands**, and **40 skill domains** — a complete foundation for AI-assisted software development, product management, content creation, and operations.

Install once, use across every project. Personalize per project with `/onboard` or `/migrate`.

## Installation

All installation commands run **inside a Claude Code session** (not your regular terminal). Start Claude Code first, then type these commands at the Claude Code prompt.

### 1. Add ai-org as a marketplace source

```
# From local path
/plugin marketplace add /path/to/ai-org

# From GitHub
/plugin marketplace add JuiceDogoUi/ai-org
```

### 2. Install the plugin

```
# User scope (default — available across all projects)
/plugin install ai-org@ai-org

# Project scope (shared with team via .claude/settings.json)
/plugin install ai-org@ai-org --scope project
```

Commands become available as `/ai-org:explore`, `/ai-org:build`, `/ai-org:review`, etc. When ai-org is the only plugin, you can also use shorthand: `/explore`, `/build`, `/review`.

## Quick Start

### New Project (empty repo)

```bash
mkdir my-project && cd my-project
git init
# Install ai-org plugin, then:
/onboard my-project
```

The `/onboard` command walks you through a guided setup:

1. **Project identity** — name, description, project type (full-stack web app, SPA, website, mobile, desktop, API, monorepo)
2. **Tech stack** — framework, CSS approach, database (questions filtered by project type, language inferred from framework)
3. **Organization** — business context, team size, workspace scope tier (Coding only, Coding + Product & Design, Full stack, or Product & Strategy only)

Then it generates a complete personalized structure:

- **CLAUDE.md** — project playbook with tech stack, commands, conventions, agent reference
- **Project-specific agents** — scaled to team size (5 core agents plus stack-specific agents for solo developers, additional operational and review agents for teams), each with project-specific system prompts referencing your stack and business context
- **Guides** — development setup, contributing guidelines (for teams), deployment checklist
- **Strategy skeleton** — persona and positioning templates pre-populated from your business context
- **Project scaffold** — directories and config files for your chosen framework (skipped if project files already exist)

### Existing Project

```bash
cd my-existing-project
# Install ai-org plugin, then:
/migrate
```

The `/migrate` command scans your project automatically — no questions needed upfront:

1. **Detects tech stack** from config files (package.json, tsconfig, angular.json, etc.)
2. **Reads existing Claude configuration** (CLAUDE.md, agents, guides, strategy)
3. **Maps existing agents to ai-org roles** by reading their system prompts (not name matching)
4. **Presents a categorized migration plan**: preserve existing agents that already cover roles, enhance them with skill references, create agents only for uncovered roles
5. **Backs up every file** before modifying anything
6. **Outputs a migration report** with role mapping table

Existing agents are never duplicated, renamed, or overwritten. ai-org fills gaps and connects the dots.

## Commands

Claude Code acts as the workflow coordinator. Commands define explicit stages and spawn specialist agents via Task() as needed.

### Workflow

| Command | Description | Model |
|---------|-------------|-------|
| `/feature` | Full product workflow — understand, research, build, review | opus |

### Discovery

| Command | Description | Model |
|---------|-------------|-------|
| `/explore` | Research an idea from all angles before deciding to build | opus |

### Building

| Command | Description | Model |
|---------|-------------|-------|
| `/build` | Build a feature end-to-end with agent spawning | opus |
| `/component` | Scaffold a UI component (spawns eng-frontend) | sonnet |
| `/test` | Write tests (spawns eng-testing) | sonnet |

### Review & Quality

| Command | Description | Model |
|---------|-------------|-------|
| `/review` | 3-round review — spawns reviewer agents | sonnet |
| `/refine` | Score your Claude Code setup across 8 dimensions | sonnet |

### Writing

| Command | Description | Model |
|---------|-------------|-------|
| `/copy` | Marketing or UX copy | opus (writer-lead) |
| `/changelog` | Generate changelog from commits | haiku |

### Operations

| Command | Description | Model |
|---------|-------------|-------|
| `/status` | Project status report | haiku |

### Setup

| Command | Description | Model |
|---------|-------------|-------|
| `/onboard` | Set up a new project with ai-org | opus |
| `/migrate` | Migrate existing project to ai-org | opus |
| `/upgrade` | Upgrade ai-org setup to latest version | opus |

## Agents

### Engineering (9)

| Agent | Model | Skills | Role |
|-------|-------|--------|------|
| eng-architect | opus | api-design, database-design, security, performance | Architecture, system design, technical planning, ADRs |
| eng-frontend | sonnet | typescript, react, angular, vue, swift, kotlin, dart, accessibility, i18n | UI for web, mobile, desktop — any platform |
| eng-backend | sonnet | api-design, database-design, security, typescript, i18n | Services, business logic, data access, schema, queries |
| eng-api | sonnet | api-design | REST/GraphQL endpoint design and contracts |
| eng-styles | sonnet | css-architecture, accessibility, performance | CSS architecture, responsive design, theming |
| eng-devops | sonnet | devops, security | CI/CD, containers, infrastructure, deployment |
| eng-testing | sonnet | testing-strategy, accessibility | Test strategy, unit/integration/e2e tests |
| eng-security | sonnet | security, compliance-frameworks | Security analysis, vulnerability assessment (read-only) |
| eng-performance | sonnet | performance | Performance profiling, complexity analysis (read-only) |

### Product & Design (2)

| Agent | Model | Skills | Role |
|-------|-------|--------|------|
| product-lead | opus | product-management, product-analytics, positioning, competitive-analysis | PRDs, requirements, roadmaps, metrics, strategy |
| design-lead | opus | css-architecture, accessibility, ux-writing | UI/UX direction, design system governance, component specs |

### Writing (1)

| Agent | Model | Skills | Role |
|-------|-------|--------|------|
| writer-lead | opus | technical-writing, content-strategy, marketing-copy, ux-writing, positioning, competitive-analysis, i18n | All writing: docs, articles, marketing, UX copy |

### Strategy & Operations (3)

| Agent | Model | Skills | Role |
|-------|-------|--------|------|
| positioning | opus | positioning, competitive-analysis, content-strategy | Product positioning using April Dunford's framework |
| researcher | opus | research-methodology, competitive-analysis, product-analytics, positioning, content-strategy, compliance-frameworks, security, performance, accessibility | All research: market, user, technology, competitive, regulatory |
| compliance | opus | compliance-frameworks, accessibility, review-process | Regulatory compliance audits with web research (read-only) |

### Review (3)

| Agent | Model | Skills | Role |
|-------|-------|--------|------|
| reviewer-code | sonnet | review-process, testing-strategy, security, performance, accessibility | Code quality, security, performance, accessibility (read-only) |
| reviewer-content | sonnet | review-process, content-strategy, technical-writing, marketing-copy, ux-writing, accessibility, i18n | All content types: docs, articles, marketing, UX (read-only) |
| reviewer-architecture | opus | review-process, api-design, database-design, security, performance, devops | System design, ADRs, scalability, infrastructure (read-only) |

## Skills

Skills are domain knowledge packages — conventions, patterns, and reference material. They inform agents but do not define their behavior.

| Skill | Description |
|-------|-------------|
| accessibility | WCAG guidelines, ARIA widget patterns, screen reader support |
| angular | Angular 17+ patterns, signals, standalone components, testing |
| api-design | REST conventions, error handling, pagination, versioning |
| codemirror | CodeMirror 6 editor framework, extensions, state management |
| competitive-analysis | Porter's Five Forces, SWOT, JTBD, value chain frameworks |
| compliance-frameworks | Audit methodology, regulatory landscape, concern-based compliance frameworks |
| content-strategy | Article structure, SEO guidelines, content planning |
| cpp | Modern C++ conventions, patterns, and best practices |
| css-architecture | BEM/ITCSS methodologies, design tokens, responsive patterns |
| dart | Dart language patterns, Flutter conventions |
| database-design | Schema conventions, migration patterns, query optimization |
| devops | CI/CD pipeline patterns, Docker best practices, deployment strategies |
| electron | Electron framework, main/renderer process, IPC patterns |
| i18n | ICU MessageFormat, translation workflows, Angular i18n, RTL support |
| java | Java 17+ patterns, records, sealed interfaces, Spring Boot conventions |
| javascript | Modern JS patterns, async/await, DOM APIs, module patterns |
| kotlin | Kotlin language patterns, Jetpack Compose, Android conventions |
| marketing-copy | Landing page frameworks, email templates, conversion copy |
| performance | Core Web Vitals, profiling patterns, optimization techniques |
| positioning | April Dunford's "Obviously Awesome" positioning methodology |
| product-analytics | Funnel analysis, A/B testing methodology, metrics frameworks |
| product-management | PRD templates, user story format, prioritization frameworks |
| python | Python language conventions, patterns, and best practices |
| qi-framework | QI Framework conventions and patterns for robotics and embedded systems |
| qml | QML and Qt Quick conventions, component patterns, property bindings |
| react | React patterns, hooks, Server Components, state management |
| research-methodology | Research frameworks, literature review methods, source evaluation, synthesis |
| review-process | 3-round review framework, round details, output format |
| rust | Rust language patterns, ownership, lifetimes, Tauri integration |
| security | OWASP Top 10, auth patterns (JWT, OAuth), vulnerability checklist |
| sql | SQL query patterns, optimization, and database best practices |
| svelte | Svelte/SvelteKit patterns, runes, stores, server routes |
| swift | Swift conventions, SwiftUI patterns, @Observable, NavigationStack |
| tauri | Tauri desktop framework patterns, IPC, commands, and configuration |
| technical-writing | API doc structure, README templates, documentation conventions |
| testing-strategy | Test pyramid, unit/integration/e2e patterns, coverage strategy |
| typescript | Type system patterns, branded types, tsconfig guide |
| ux-writing | Microcopy guidelines, error message patterns, voice and tone |
| vue | Vue 3 patterns, Composition API, Pinia, Nuxt conventions |
| xterm | xterm.js terminal emulator, addons, styling |

## Architecture

### Claude Code as Coordinator

Claude Code itself acts as the workflow coordinator. Commands define explicit stages and spawn specialist agents via the Task tool at each stage. This removes the need for a separate orchestrator agent.

```
/explore   →  Claude Code spawns researcher + product-lead for multi-angle discovery
/build     →  Claude Code analyzes, decomposes, and spawns domain agents
/feature   →  Claude Code orchestrates 4 stages: understand → research → build → review
/test      →  Claude Code detects framework, spawns eng-testing, runs tests
/component →  Claude Code scans conventions, spawns eng-frontend, validates
/review    →  Claude Code spawns reviewer agents in 3 rounds
/refine    →  Claude Code scans project config and scores setup maturity
```

### Model Tiers

| Tier | Agents | Use Case |
|------|--------|----------|
| Opus (8) | eng-architect, product-lead, design-lead, writer-lead, positioning, researcher, reviewer-architecture, compliance | Complex reasoning, architecture, strategy, regulatory analysis |
| Sonnet (10) | eng-frontend, eng-backend, eng-api, eng-styles, eng-devops, eng-testing, eng-security, eng-performance, reviewer-code, reviewer-content | Standard implementation, focused tasks |
| Haiku (2 commands) | changelog, status | Fast lookup, simple aggregation |

### Skill Isolation

Skills are reference material, not identity. An agent's system prompt defines HOW it thinks. Skills provide WHAT it knows. This separation means:

- Multiple agents share the same skill (eng-frontend and eng-backend both use typescript)
- Skills update without changing agent behavior
- Agents maintain clear boundaries regardless of skill breadth

### Direct vs Delegated Agents

Commands are workflows — they trigger teams, flows, and multi-agent processes, not single agents. Of the 18 agents, 11 have direct command spawning and 7 are delegation-only, reached when Claude Code or a workflow decomposes work via the Task tool:

- **Direct** (11): eng-architect, eng-frontend, eng-backend, eng-api, eng-devops, eng-testing, eng-performance, positioning, product-lead, researcher, writer-lead
- **Delegated** (7): eng-styles, eng-security, design-lead, compliance, reviewer-code, reviewer-content, reviewer-architecture

Delegated agents are fully functional — they simply participate in multi-agent workflows (like `/review`, `/build`, `/feature`) rather than owning a standalone command.

### Read-Only Agents

These agents have no Write or Edit tools — they analyze and recommend but cannot modify code:

- **Security-sensitive**: eng-security, eng-performance, compliance
- **Review**: reviewer-code, reviewer-content, reviewer-architecture
- **Design**: design-lead

## Project Customization

ai-org provides a general foundation. Real projects need specific context — your tech stack, your conventions, your business domain.

### The Layering Model

```
Project root
├── .claude/                  ←  Agent infrastructure: agents, guides, commands, plans
├── strategy/                 ←  Product artifacts: personas, positioning, research
├── initiatives/              ←  Feature workflows: initiative docs, specs, reviews
│
└── ai-org plugin (installed) ←  General: coding patterns, frameworks,
                                  security checklists, writing conventions
```

### How It Works

1. **ai-org skills** provide baseline domain knowledge (TypeScript patterns, security checklists, accessibility guidelines)
2. **Project agents** in `.claude/agents/` shadow ai-org's generic agents with project-specific system prompts
3. **Project agents reference ai-org skills** via the `skills:` frontmatter field — they get the knowledge without losing project context
4. **Strategy docs** (personas, positioning, competitive research) give agents business context that no generic plugin can provide
5. **Guides** encode your team's specific workflows (how to create content, how to deploy, how to contribute)

### What Each Layer Provides

| Concern | ai-org (general) | Project .claude/ (specific) |
|---------|------------------|----------------------------|
| TypeScript patterns | Language conventions, type patterns | Your tsconfig, your module structure |
| Code review | OWASP checklist, performance patterns | Your pre-merge checklist, your component standards |
| Content writing | Article structure, SEO guidelines | Your brand voice, your personas, your content calendar |
| Competitive analysis | Porter's Five Forces, SWOT framework | Your actual competitors, your positioning |
| Deployment | CI/CD patterns, Docker best practices | Your environments, your rollback procedure |

### Getting Started

- **New project**: Run `/onboard` — generates everything from scratch based on your answers
- **Existing project**: Run `/migrate` — scans your project, preserves what exists, fills gaps
- **Manual**: Create `.claude/agents/` with your own agent files that reference ai-org skills

## Utilities

| Script | Purpose |
|--------|---------|
| `scripts/detect-stack.sh` | Detects project tech stack and suggests relevant agents. Outputs JSON. Requires `jq`. |

## License

MIT
