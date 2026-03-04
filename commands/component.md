---
name: component
description: Scaffold a UI component with convention-aware context
argument-hint: "[component name and description]"
user-invocable: true
context: fork
model: sonnet
---

# Component: $ARGUMENTS

You are Claude Code coordinating component creation.

## How to Spawn Agents

Use the Task tool. Spawn each agent by name (e.g., `eng-frontend`).

**If an agent doesn't exist:** Handle that task directly using the same approach.

---

## Step 1: Analyze Project

**You (Claude Code):** Before spawning any agent, gather context:

1. **Detect framework** — check package.json, angular.json, pubspec.yaml, Cargo.toml,
   build.gradle, etc. Identify: React, Angular, Vue, Svelte, Swift, Kotlin, Flutter,
   Qt/QML, or other.

2. **Find component directory** — locate where existing components live
   (e.g., `src/components/`, `app/components/`, `lib/widgets/`).

3. **Scan conventions** from 2–3 existing components:
   - File structure: single file, folder with index, co-located tests/styles?
   - Naming: PascalCase, kebab-case, snake_case?
   - Patterns: functional vs class, composition API vs options, hooks used?
   - Exports: default vs named, barrel files?

4. **Check for duplicates** — search for components with similar names or purposes.
   If found, warn the user: "A similar component `{name}` already exists at `{path}`.
   Proceed anyway?"

---

## Step 2: Build

**Spawn: eng-frontend** with:
- Framework detected
- Component directory path
- Conventions discovered (file structure, naming, patterns, exports)
- The user's component description from $ARGUMENTS
- Any duplicate warnings

---

## Step 3: Validate

**You (Claude Code):** After the agent finishes:

1. Verify the new component matches the conventions found in Step 1
2. Check that imports resolve (no missing dependencies or broken paths)
3. If tests were co-located in existing components, verify a test file was created
4. If a barrel/index file exists in the component directory, verify the new component is exported

Report any issues found. If clean, summarize what was created:

```
## Created: {ComponentName}

- **Path:** {file path(s)}
- **Framework:** {detected framework}
- **Conventions:** {matched/deviated}
- **Tests:** {created/skipped}
```
