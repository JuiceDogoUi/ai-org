---
name: testing-strategy
description: Test pyramid, coverage strategy, and testing patterns across web, mobile, and backend platforms.
user-invocable: false
---

# Testing Strategy

## Test Pyramid

| Level | Proportion | Speed | Scope |
|-------|------------|-------|-------|
| Unit | 70% | Fast (ms) | Single function/method |
| Integration | 20% | Medium (s) | Module interactions, APIs, DB |
| E2E | 10% | Slow (min) | Critical user journeys |

## Principles

- Test behavior, not implementation — tests survive refactoring
- One concept per test, one clear assertion focus
- Independent tests — no shared mutable state
- Deterministic — no flaky time/network dependencies
- Descriptive names: `should return 404 when user not found`

## What to Test

- Happy path (expected input → expected output)
- Edge cases (empty, null, boundary values)
- Error cases (invalid input, failures, timeouts)
- State transitions and side effects

## What NOT to Test

- Framework internals (reconciliation, change detection)
- Third-party library behavior
- Trivial code with no logic
- Implementation details (private methods)

## Test Types by Platform

### Frontend
```javascript
// Component test with Testing Library
test('submits form with valid data', async () => {
  render(<LoginForm onSubmit={mockSubmit} />);

  await userEvent.type(screen.getByLabelText('Email'), 'test@example.com');
  await userEvent.type(screen.getByLabelText('Password'), 'password123');
  await userEvent.click(screen.getByRole('button', { name: 'Sign In' }));

  expect(mockSubmit).toHaveBeenCalledWith({
    email: 'test@example.com',
    password: 'password123'
  });
});
```

- **Component tests**: Render, interact, assert (Testing Library)
- **Visual regression**: Screenshot comparison for UI changes
- **Accessibility**: Automated a11y checks (axe-core)

### Backend
```javascript
// API test
test('GET /users/:id returns user when found', async () => {
  const user = await createUser({ name: 'Test' });

  const response = await request(app)
    .get(`/users/${user.id}`)
    .expect(200);

  expect(response.body.data.name).toBe('Test');
});

test('GET /users/:id returns 404 when not found', async () => {
  await request(app)
    .get('/users/nonexistent')
    .expect(404);
});
```

- **API tests**: Request/response validation, status codes, payloads
- **Database tests**: Queries, migrations, constraints
- **Service tests**: Business logic in isolation

### Mobile
- **UI tests**: Interactions, navigation, gestures
- **Device matrix**: Test across OS versions, screen sizes
- **Platform-specific**: Permissions, lifecycle, background states

## Coverage Strategy

- **Target**: 80% line coverage baseline
- **Focus**: Business logic, error handling, edge cases
- **Skip**: Trivial getters, framework internals, generated code
- **Improve**: Add tests when fixing bugs (regression prevention)

## Mocking Guidelines

### When to Mock
- Network calls (use msw or nock)
- Databases (in unit tests; use real DB in integration)
- Third-party services
- Time (`jest.useFakeTimers()`)
- Random values

### When NOT to Mock
- The code under test
- Internal modules (usually)
- Simple utilities

### Prefer Dependency Injection
```javascript
// Testable: dependency injected
class OrderService {
  constructor(private paymentGateway: PaymentGateway) {}

  async checkout(order: Order) {
    return this.paymentGateway.charge(order.total);
  }
}

// Test with mock
const mockGateway = { charge: jest.fn().mockResolvedValue({ success: true }) };
const service = new OrderService(mockGateway);
```

## Test Data

### Factories
```javascript
// Use factories for consistent test data
const createUser = (overrides = {}) => ({
  id: faker.string.uuid(),
  email: faker.internet.email(),
  name: faker.person.fullName(),
  ...overrides
});

test('displays user name', () => {
  const user = createUser({ name: 'Alice' });
  render(<UserProfile user={user} />);
  expect(screen.getByText('Alice')).toBeInTheDocument();
});
```

### Database Seeding
- Use transactions for isolation (rollback after each test)
- Or truncate tables between tests
- Don't rely on specific IDs in test data

## Continuous Integration

- Run tests on every PR
- Fail build on test failure
- Track coverage trends
- Parallelize test suites
- Separate fast (unit) from slow (E2E) pipelines

## Avoid

- **Testing implementation details** — Test public behavior, not internals
- **100% coverage targets** — Diminishing returns; focus on critical paths
- **Flaky tests** — Fix or delete; flaky tests erode trust
- **Slow test suites** — Parallelize; move slow tests to separate pipeline
- **Testing third-party code** — Trust libraries; mock at boundaries
- **Shared mutable state** — Each test should set up its own state
- **Over-mocking** — Too many mocks means testing mocks, not code
- **Testing without assertions** — Every test needs meaningful assertions
- **Ignoring test maintenance** — Refactor tests with code; delete obsolete tests
- **Skipping error paths** — Error handling needs testing too
