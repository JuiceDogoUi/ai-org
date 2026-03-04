---
name: refine
description: Score your Claude Code setup across 8 dimensions
argument-hint: "[optional: focus dimension name]"
user-invocable: true
context: fork
model: sonnet
allowed-tools: Bash(git *), Bash(wc *), Bash(ls *), Read, Grep, Glob
---

# Refine: $ARGUMENTS

You are Claude Code performing a self-audit of this project's Claude Code configuration.
Scan the actual files — never assume or guess. Every score must cite concrete evidence.

---

## What to Scan

Scan these locations relative to the current working directory:

| Asset            | Locations to check                                                          |
|------------------|-----------------------------------------------------------------------------|
| CLAUDE.md        | `./CLAUDE.md`, `.claude/CLAUDE.md`                                          |
| Commands         | `./commands/*.md`, `.claude/commands/*.md`                                  |
| Skills           | `./skills/*/SKILL.md`, `.claude/skills/*/SKILL.md`                          |
| Agents           | `./agents/*.md`, `.claude/agents/*.md`                                      |
| Hooks            | `.claude/settings.json`, `.claude/settings.local.json`, `~/.claude/settings.json` → `hooks` key |
| MCP servers      | `.claude/settings.json`, `.claude/settings.local.json`, `~/.claude/settings.json` → `mcpServers` key |
| Permissions      | `.claude/settings.json`, `.claude/settings.local.json` → `permissions` key |
| Memory           | `.claude/memory/`, agent frontmatter `memory:` field                        |
| @references      | `@` directives inside CLAUDE.md                                             |

---

## Scoring Rubric

### 1. CLAUDE.md Quality (0–3)

Read every CLAUDE.md found. Score based on **what is present**:

| Score | Criteria |
|-------|----------|
| 0     | No CLAUDE.md exists |
| 1     | Exists but minimal — under 20 lines, missing project identity or tech stack |
| 2     | Has project identity + tech stack + conventions, but missing anti-patterns or workflow rules |
| 3     | Comprehensive — project identity, tech stack, conventions, anti-patterns, and workflow rules |

**Evidence to collect:** line count, which sections exist (identity, tech stack, conventions, anti-patterns, workflow), @references count.

---

### 2. Development Workflow (0–3)

Count and categorize all commands found.

| Score | Criteria |
|-------|----------|
| 0     | No custom commands |
| 1     | 1–3 commands — covers only one lifecycle phase |
| 2     | 4–8 commands — covers 2–3 lifecycle phases (e.g., build + review) |
| 3     | 9+ commands — covers 4+ phases (plan, build, test, review, deploy, docs) |

**Lifecycle phases:** Discover (explore), Build (build, feature, component), Test (test), Review (review, refine), Write (copy, changelog), Operations (status), Setup (onboard, migrate, upgrade).

**Evidence to collect:** command count, which phases are covered, any gaps.

---

### 3. Skills Coverage (0–3)

Count skill directories and check their contents.

| Score | Criteria |
|-------|----------|
| 0     | No skills defined |
| 1     | 1–5 skills, or most skills have only a SKILL.md with no supplementary files |
| 2     | 6–15 skills, majority have SKILL.md + at least 1 supplementary file (patterns, guides) |
| 3     | 16+ skills, most have SKILL.md + supplementary files + anti-patterns section |

**Evidence to collect:** skill count, skills missing SKILL.md, skills with supplementary files, skills with anti-patterns sections.

---

### 4. Agent Architecture (0–3)

Count agents and evaluate their design.

| Score | Criteria |
|-------|----------|
| 0     | No custom agents |
| 1     | 1–3 agents, no clear specialization or tool constraints |
| 2     | 4–8 agents, clear specializations, some have tool constraints or boundaries |
| 3     | 9+ agents, well-defined roles, tool constraints, explicit boundaries ("What You Do NOT Do"), handoffs between agents |

**Evidence to collect:** agent count, model tiers used, read-only agents, agents with explicit boundaries, agents with handoff sections.

---

### 5. Automation — Hooks (0–3)

Check all settings files for the `hooks` key.

| Score | Criteria |
|-------|----------|
| 0     | No hooks configured |
| 1     | Hooks cover 1 concern (e.g., only linting or only tests) |
| 2     | Hooks cover 2 concerns (e.g., test + lint, or format + typecheck) |
| 3     | Hooks cover 3+ concerns (test, lint, typecheck, format, commit validation) |

**Evidence to collect:** concerns covered, trigger points used (PreToolUse, PostToolUse, etc.), what commands they run.

---

### 6. Tool Integration — MCP Servers (0–3)

Check settings files for `mcpServers` key.

| Score | Criteria |
|-------|----------|
| 0     | No MCP servers configured |
| 1     | 1 MCP server |
| 2     | 2–3 MCP servers |
| 3     | 4+ MCP servers or a well-integrated ecosystem (e.g., database + API + monitoring) |

**Evidence to collect:** MCP server names, what they connect to, whether they're project-specific or global.

---

### 7. Guard Rails (0–3)

Evaluate safety constraints across all configuration.

| Score | Criteria |
|-------|----------|
| 0     | No safety constraints — no permission rules, no anti-patterns, no agent boundaries |
| 1     | Basic: has permission allow/deny rules OR anti-patterns in CLAUDE.md |
| 2     | Moderate: permissions configured + anti-patterns in CLAUDE.md + some agents have boundaries |
| 3     | Strong: permissions + anti-patterns + read-only agents for review/audit + agent boundaries + skill anti-patterns |

**Evidence to collect:** permission rules count, anti-pattern sections found, read-only agents, "What You Do NOT Do" sections.

---

### 8. Context Efficiency (0–3)

Evaluate how well context is managed to minimize token usage.

| Score | Criteria |
|-------|----------|
| 0     | No context splitting — everything in one large file or no structure at all |
| 1     | CLAUDE.md over 150 lines, no @references, skills not split into directories |
| 2     | CLAUDE.md under 100 lines with @references, skills split into directories, agents have scoped skill lists |
| 3     | Optimal — CLAUDE.md concise (<80 lines), @references for detail files, skills well-scoped, agents declare only needed skills, memory configured for persistence |

**Evidence to collect:** CLAUDE.md line count, @reference count, average skills per agent, memory configuration.

---

## Grading Scale

| Range  | Grade | Meaning                                          |
|--------|-------|--------------------------------------------------|
| 22–24  | A     | Production-grade setup, minimal improvements     |
| 18–21  | B     | Solid foundation, refine edges                   |
| 13–17  | C     | Functional but gaps reduce effectiveness         |
| 8–12   | D     | Basic setup, significant improvements needed     |
| 0–7    | F     | Minimal configuration, most features unused      |

---

## Process

1. **Scan** — Read all files listed in "What to Scan". Use Glob to discover, Read to inspect.
2. **Score** — Apply each rubric strictly. Only give credit for what you can verify.
3. **Evidence** — For each dimension, note 1–2 specific observations.
4. **Recommend** — For any dimension scoring below 3, give one concrete next step.

If `$ARGUMENTS` names a specific dimension, still produce the full scorecard but expand
that dimension with detailed findings and a multi-step improvement plan.

---

## Output Format

```
## Claude Code Setup Audit

**Project:** {project name from CLAUDE.md or directory name}
**Date:** {today}

### Scorecard

| # | Dimension            | Score | Evidence                                           |
|---|----------------------|-------|----------------------------------------------------|
| 1 | CLAUDE.md Quality    | ?/3   | {1-line evidence}                                  |
| 2 | Development Workflow | ?/3   | {1-line evidence}                                  |
| 3 | Skills Coverage      | ?/3   | {1-line evidence}                                  |
| 4 | Agent Architecture   | ?/3   | {1-line evidence}                                  |
| 5 | Automation (Hooks)   | ?/3   | {1-line evidence}                                  |
| 6 | Tool Integration     | ?/3   | {1-line evidence}                                  |
| 7 | Guard Rails          | ?/3   | {1-line evidence}                                  |
| 8 | Context Efficiency   | ?/3   | {1-line evidence}                                  |
|   | **TOTAL**            | **?/24** | **Grade: {letter}**                             |

### Top 3 Improvements

{Ordered by impact — highest-impact first}

1. **{Dimension}** (current: ?/3 → target: ?/3)
   {Concrete action: what to create/modify and why it matters}

2. **{Dimension}** (current: ?/3 → target: ?/3)
   {Concrete action}

3. **{Dimension}** (current: ?/3 → target: ?/3)
   {Concrete action}
```

If a specific dimension was requested in $ARGUMENTS, add after the improvements:

```
### Deep Dive: {Dimension Name}

**Current state:**
{Detailed findings with file paths and line counts}

**Improvement plan:**
1. {Step with specific file to create or modify}
2. {Step}
3. {Step}

**Example:**
{Show a concrete example of what good looks like for this dimension}
```
