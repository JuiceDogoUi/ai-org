# E2E Testing Patterns

## Principles
- Test critical user flows, not every page
- Use stable selectors (data-testid, roles) not CSS classes
- Keep tests independent -- each test sets up its own state
- Use API calls for setup/teardown, not UI interactions

## Common Flows to Cover
- Authentication (signup, login, logout)
- Core CRUD operations
- Payment/checkout (if applicable)
- Navigation between key pages
- Error recovery (network failure, invalid input)

## Frameworks
- **Cypress** — Good for component and E2E testing with built-in time travel debugging
- **Playwright** — Cross-browser support (Chromium, Firefox, WebKit), auto-wait, and built-in test generation

## Page Object Pattern

### Cypress
```typescript
class LoginPage {
  get emailInput() { return cy.findByRole('textbox', { name: /email/i }); }
  get passwordInput() { return cy.findByLabelText(/password/i); }
  get submitButton() { return cy.findByRole('button', { name: /sign in/i }); }

  login(email: string, password: string) {
    this.emailInput.type(email);
    this.passwordInput.type(password);
    this.submitButton.click();
  }
}
```

### Playwright
```typescript
class LoginPage {
  constructor(private page: Page) {}

  async login(email: string, password: string) {
    await this.page.getByRole('textbox', { name: /email/i }).fill(email);
    await this.page.getByLabel(/password/i).fill(password);
    await this.page.getByRole('button', { name: /sign in/i }).click();
  }
}
```

## API Setup
```typescript
beforeEach(() => {
  cy.request('POST', '/api/test/reset');
  cy.request('POST', '/api/test/seed', { fixture: 'basic-users' });
});
```
