---
name: test
description: Write tests with coverage-aware targeting
argument-hint: "[file, directory, or feature to test]"
user-invocable: true
context: fork
model: sonnet
---

# Test: $ARGUMENTS

You are Claude Code coordinating test creation.

## How to Spawn Agents

Use the Task tool. Spawn each agent by name (e.g., `eng-testing`).

**If an agent doesn't exist:** Handle that task directly using the same approach.

---

## Step 1: Analyze

**You (Claude Code):** Before spawning any agent, gather context:

1. **Detect test framework** — check package.json scripts and devDependencies,
   pytest.ini, jest.config, vitest.config, angular.json, pubspec.yaml, Cargo.toml, etc.
   Identify: Jest, Vitest, Playwright, Cypress, pytest, XCTest, JUnit, Go testing, etc.

2. **Find test conventions** from 2–3 existing test files:
   - Location: co-located (`Component.test.tsx`), separate (`__tests__/`, `test/`)?
   - Naming: `.test.`, `.spec.`, `_test.`?
   - Patterns: describe/it, test(), AAA, fixtures, mocks, test utils?
   - Setup: beforeEach patterns, factory functions, custom render wrappers?

3. **Identify target** based on $ARGUMENTS:
   - If a file/directory is specified → test that target
   - If a feature description → find the relevant source files
   - **If no argument given** → scan for coverage gaps:
     - Find source files with no corresponding test file
     - Prioritize: files with business logic > utilities > UI components > config
     - Present the top 3 untested files and ask user which to test

---

## Step 2: Build

**Spawn: eng-testing** with:
- Test framework and runner detected
- Conventions discovered (location, naming, patterns, setup)
- The target files to test
- Any existing related tests (for consistency)

---

## Step 3: Verify

**You (Claude Code):** After the agent finishes:

1. **Run the tests** using the detected test command (e.g., `npm test`, `pytest`, `go test`)
   scoped to the new test files only
2. If tests **pass** → report results
3. If tests **fail** → analyze failures:
   - If it's an import/setup issue → fix directly
   - If it's a logic issue in the test → spawn eng-testing again with the failure context
   - Max 2 fix attempts, then report remaining failures to user

Report:

```
## Tests: {target}

- **Framework:** {detected}
- **Files created:** {list}
- **Results:** {passed}/{total} passing
- **Coverage:** {new areas covered}
```
