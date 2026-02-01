---
name: testing-strategy
description: Test pyramid, coverage strategy, and testing patterns. Use when writing tests, designing test strategy, or reviewing test quality.
user-invocable: false
---

# Testing Strategy

## Test Pyramid
- **Unit tests** (70%): Fast, isolated, test single functions/methods
- **Integration tests** (20%): Test module interactions, API endpoints, DB queries
- **E2E tests** (10%): Test critical user flows end-to-end

## Principles
- Test behavior, not implementation
- Each test should have one clear assertion focus
- Tests should be independent -- no shared mutable state
- Tests should be deterministic -- no flaky dependencies
- Name tests by what they verify: `should return 404 when user not found`

## What to Test
- Happy path (expected input -> expected output)
- Edge cases (empty, null, boundary values)
- Error cases (invalid input, failures, timeouts)
- State transitions (if applicable)

## What NOT to Test
- Framework internals (Angular change detection, React reconciliation)
- Third-party library behavior
- Trivial getters/setters with no logic
- Implementation details (private methods, internal state)

For unit testing patterns, see [unit-testing.md](unit-testing.md).
For e2e testing, see [e2e-testing.md](e2e-testing.md).
