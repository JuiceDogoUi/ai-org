# Unit Testing Patterns

## Arrange-Act-Assert
```typescript
it('should calculate total with tax', () => {
  // Arrange
  const items = [{ price: 10, qty: 2 }, { price: 5, qty: 1 }];

  // Act
  const total = calculateTotal(items, { taxRate: 0.1 });

  // Assert
  expect(total).toBe(27.5);
});
```

## Mocking External Dependencies
```typescript
// Mock the module
jest.mock('./emailService');

it('should send welcome email on signup', async () => {
  const sendEmail = jest.mocked(emailService.send);
  sendEmail.mockResolvedValue({ success: true });

  await userService.signup({ email: 'test@example.com' });

  expect(sendEmail).toHaveBeenCalledWith(
    expect.objectContaining({ to: 'test@example.com', template: 'welcome' })
  );
});
```

## Testing Errors
```typescript
it('should throw on invalid email', () => {
  expect(() => validateEmail('not-an-email')).toThrow('Invalid email format');
});

it('should reject on network failure', async () => {
  fetchMock.mockRejectedValue(new Error('Network error'));
  await expect(api.getUser('123')).rejects.toThrow('Network error');
});
```
