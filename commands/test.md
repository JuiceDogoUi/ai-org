---
name: test
description: Write tests for a file, feature, or module
argument-hint: "[target to test]"
context: fork
agent: eng-testing
---

Write tests for: $ARGUMENTS

## Process

1. Analyze the target code to understand its behavior and interfaces
2. Identify test cases: happy path, edge cases, error cases
3. Write tests following the project's existing testing conventions
4. Ensure meaningful assertions -- test behavior, not implementation
5. Run the tests and fix any failures

## Standards

- Match the project's test framework and file naming conventions
- Use descriptive test names that explain the expected behavior
- Keep each test focused on one behavior
- Avoid testing implementation details -- test public interfaces
- Include setup and teardown where appropriate
- Mock external dependencies, not internal code

## Output

- Test file(s) following the project's test file naming convention (e.g., `*.test.ts`, `*.spec.ts`, `*Test.java`)
- All new tests passing
- Coverage of happy path, edge cases, and error cases

> Related: `/build` to implement the feature these tests cover, `/review` to review test quality.
