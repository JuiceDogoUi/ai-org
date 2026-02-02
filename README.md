# ai-org

A reusable AI organization plugin for Claude Code. Provides **29 specialist agents**, **26 commands**, and **26 skill domains** — a complete foundation for AI-assisted software development, product management, content creation, and operations.

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

Commands become available as `/ai-org:plan`, `/ai-org:build`, `/ai-org:review`, etc. When ai-org is the only plugin, you can also use shorthand: `/plan`, `/build`, `/review`.

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
5. **Updates the orchestrator** with a project-specific routing table using your actual agent names
6. **Backs up every file** before modifying anything
7. **Outputs a migration report** with role mapping table

Existing agents are never duplicated, renamed, or overwritten. ai-org fills gaps and connects the dots.

## Commands

### Workflow

| Command | Description | Routed To |
|---------|-------------|-----------|
| `/feature` | Full product workflow — understand, research, build, review | orchestrator |

### Planning

| Command | Description | Routed To |
|---------|-------------|-----------|
| `/plan` | Create an implementation plan | orchestrator |
| `/research` | Deep research with synthesis | researcher |
| `/prd` | Product requirements document | product-manager |
| `/position` | Define product positioning (April Dunford framework) | positioning |
| `/adr` | Architecture Decision Record | orchestrator |
| `/estimate` | Effort estimation | project-manager |

### Building

| Command | Description | Routed To |
|---------|-------------|-----------|
| `/build` | Build a feature end-to-end (with auto-review) | orchestrator |
| `/component` | Scaffold a UI component | eng-frontend |
| `/api` | Design or build an API endpoint | eng-api |
| `/db-migrate` | Create a database migration | eng-database |
| `/test` | Write tests | eng-testing |

### Review & Quality

| Command | Description | Routed To |
|---------|-------------|-----------|
| `/review` | 3-round review — functional, quality, compliance | orchestrator |
| `/audit` | Security and accessibility audit | orchestrator |
| `/refactor` | Refactor with pre/post review | orchestrator |
| `/perf` | Performance analysis | eng-performance |

### Writing

| Command | Description | Routed To |
|---------|-------------|-----------|
| `/article` | Write a blog post or article | writer-content |
| `/docs` | Generate documentation | writer-technical |
| `/copywrite` | Marketing or UX copy | orchestrator |
| `/changelog` | Generate changelog from commits | orchestrator (haiku) |

### Operations

| Command | Description | Routed To |
|---------|-------------|-----------|
| `/deploy` | Deployment workflow (requires confirmation at each step, model invocation disabled for safety) | eng-devops |
| `/sprint` | Sprint planning | project-manager |
| `/status` | Project status report | orchestrator (haiku) |

### Setup

| Command | Description | Routed To |
|---------|-------------|-----------|
| `/onboard` | Set up a new project with ai-org | orchestrator |
| `/migrate` | Migrate existing project to ai-org | orchestrator |
| `/upgrade` | Upgrade ai-org setup to latest version | orchestrator |

## Agents

### Engineering (11)

| Agent | Model | Skills | Role |
|-------|-------|--------|------|
| eng-frontend | sonnet | typescript, angular, javascript, css-architecture, i18n | Frontend components, pages, SPA architecture |
| eng-backend | sonnet | java, typescript, database-design, i18n | Services, APIs, business logic, data access |
| eng-api | sonnet | api-design, typescript, java | REST/GraphQL endpoint design and contracts |
| eng-database | sonnet | database-design | Schema design, migrations, query optimization |
| eng-mobile | sonnet | swift, i18n | iOS/mobile features, platform patterns |
| eng-desktop | sonnet | typescript, javascript, i18n | Desktop app features (Electron) |
| eng-styles | sonnet | css-architecture | CSS architecture, responsive design, theming |
| eng-devops | sonnet | devops | CI/CD, Docker, infrastructure, deployment |
| eng-testing | sonnet | testing-strategy | Test strategy, unit/integration/e2e tests |
| eng-security | sonnet | security | Security analysis, vulnerability assessment (read-only) |
| eng-performance | sonnet | performance | Performance profiling, optimization (read-only) |

### Product & Design (5)

| Agent | Model | Skills | Role |
|-------|-------|--------|------|
| product-manager | opus | product-management, positioning | PRDs, requirements, user stories, roadmaps |
| product-analyst | sonnet | product-analytics | Data analysis, metrics, A/B tests, funnels |
| design-ux | sonnet | ux-writing, accessibility | UX flows, wireframes, usability research |
| design-ui | sonnet | css-architecture, accessibility | UI specs, visual guidelines, component behavior |
| design-system | sonnet | css-architecture | Design tokens, component library standards |

### Writing & Content (4)

| Agent | Model | Skills | Role |
|-------|-------|--------|------|
| writer-technical | sonnet | technical-writing | API docs, READMEs, architecture docs |
| writer-content | opus | content-strategy | Blog posts, articles, thought leadership |
| writer-ux | sonnet | ux-writing, i18n | Microcopy, error messages, UI text |
| writer-marketing | sonnet | marketing-copy, content-strategy, positioning, competitive-analysis | Landing pages, emails, ad copy |

### Strategy & Operations (5)

| Agent | Model | Skills | Role |
|-------|-------|--------|------|
| strategist | opus | competitive-analysis, positioning | Business strategy, market research, tech evaluation |
| positioning | opus | positioning, competitive-analysis, content-strategy | Product positioning using April Dunford's framework |
| researcher | opus | research-methodology | Deep research, literature review, synthesis |
| compliance | sonnet | compliance-frameworks, accessibility, review-process | GDPR, WCAG, license audits (read-only) |
| project-manager | sonnet | project-planning | Sprint planning, task breakdown, estimation |

### Review (3)

| Agent | Model | Skills | Role |
|-------|-------|--------|------|
| reviewer-code | sonnet | testing-strategy, security, review-process | Code quality, security, performance review (read-only) |
| reviewer-content | sonnet | content-strategy, ux-writing, review-process | Content accuracy, voice, SEO review (read-only) |
| reviewer-architecture | opus | api-design, database-design, review-process | Architecture review, ADR evaluation (read-only) |

### Orchestration (1)

| Agent | Model | Skills | Role |
|-------|-------|--------|------|
| orchestrator | opus | — | Routes multi-domain requests, coordinates agents via Task tool |

## Skills

Skills are domain knowledge packages — conventions, patterns, and reference material. They inform agents but do not define their behavior.

| Skill | Description |
|-------|-------------|
| accessibility | WCAG guidelines, ARIA widget patterns, screen reader support |
| angular | Angular 17+ patterns, signals, standalone components, testing |
| api-design | REST conventions, error handling, pagination, versioning |
| competitive-analysis | Porter's Five Forces, SWOT, JTBD, value chain frameworks |
| compliance-frameworks | GDPR checklist, WCAG checklist, SOX controls |
| content-strategy | Article structure, SEO guidelines, content planning |
| css-architecture | BEM/ITCSS methodologies, design tokens, responsive patterns |
| database-design | Schema conventions, migration patterns, query optimization |
| devops | CI/CD pipeline patterns, Docker best practices, deployment strategies |
| i18n | ICU MessageFormat, translation workflows, Angular i18n, RTL support |
| java | Java 17+ patterns, records, sealed interfaces, Spring Boot conventions |
| javascript | Modern JS patterns, async/await, DOM APIs, module patterns |
| marketing-copy | Landing page frameworks, email templates, conversion copy |
| performance | Core Web Vitals, profiling patterns, optimization techniques |
| positioning | April Dunford's "Obviously Awesome" positioning methodology |
| product-analytics | Funnel analysis, A/B testing methodology, metrics frameworks |
| product-management | PRD templates, user story format, prioritization frameworks |
| project-planning | Sprint templates, estimation methods, dependency mapping |
| research-methodology | Research frameworks, literature review methods, source evaluation, synthesis |
| review-process | 3-round review framework, round details, output format |
| security | OWASP Top 10, auth patterns (JWT, OAuth), vulnerability checklist |
| swift | Swift conventions, SwiftUI patterns, @Observable, NavigationStack |
| technical-writing | API doc structure, README templates, documentation conventions |
| testing-strategy | Test pyramid, unit/integration/e2e patterns, coverage strategy |
| typescript | Type system patterns, branded types, tsconfig guide |
| ux-writing | Microcopy guidelines, error message patterns, voice and tone |

## Architecture

### Hybrid Orchestrator Model

Most commands route directly to a single specialist agent — no orchestrator overhead. Only complex, multi-domain, or ambiguous requests go through the orchestrator, which decomposes work and delegates via the Task tool.

```
/test    →  eng-testing           (direct — single domain)
/component → eng-frontend         (direct — single domain)
/review  →  orchestrator          (3-round — functional, quality, compliance)
/build   →  orchestrator          (multi-domain — decomposes, delegates, auto-reviews)
/feature →  orchestrator          (4-stage — understand, research, build, review)
```

### Model Tiers

| Tier | Agents | Use Case |
|------|--------|----------|
| Opus (7) | orchestrator, product-manager, writer-content, strategist, positioning, researcher, reviewer-architecture | Complex reasoning, architecture, strategy |
| Sonnet (22) | All engineering, design, other writing, operations, review | Standard implementation, focused tasks |
| Haiku (2 commands) | changelog, status (model override on orchestrator) | Fast lookup, simple aggregation |

### Skill Isolation

Skills are reference material, not identity. An agent's system prompt defines HOW it thinks. Skills provide WHAT it knows. This separation means:

- Multiple agents share the same skill (eng-frontend and eng-backend both use typescript)
- Skills update without changing agent behavior
- Agents maintain clear boundaries regardless of skill breadth

### Direct vs Delegated Agents

Commands are workflows — they trigger teams, flows, and multi-agent processes, not single agents. Of the 29 agents, 13 have direct command routing and 16 are delegation-only, reached when the orchestrator or a workflow decomposes work via the Task tool:

- **Direct** (13): orchestrator, eng-frontend, eng-api, eng-database, eng-devops, eng-testing, eng-performance, positioning, product-manager, project-manager, researcher, writer-content, writer-technical
- **Delegated** (16): eng-backend, eng-mobile, eng-desktop, eng-styles, eng-security, product-analyst, design-ux, design-ui, design-system, writer-ux, writer-marketing, strategist, compliance, reviewer-code, reviewer-content, reviewer-architecture

Delegated agents are fully functional — they simply participate in multi-agent workflows (like `/review`, `/build`, `/feature`) rather than owning a standalone command.

### Read-Only Agents

These agents have no Write or Edit tools — they analyze and recommend but cannot modify code:

- **Security-sensitive**: eng-security, eng-performance, compliance
- **Review**: reviewer-code, reviewer-content, reviewer-architecture
- **Analysis**: product-analyst

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
