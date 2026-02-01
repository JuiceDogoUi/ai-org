# Angular Testing Strategies

## Component Testing with TestBed
```typescript
describe('UserCardComponent', () => {
  it('should display user name', async () => {
    await TestBed.configureTestingModule({
      imports: [UserCardComponent]
    }).compileComponents();

    const fixture = TestBed.createComponent(UserCardComponent);
    fixture.componentRef.setInput('user', { name: 'Alice', email: 'a@b.com' });
    fixture.detectChanges();

    expect(fixture.nativeElement.textContent).toContain('Alice');
  });
});
```

## Service Testing
```typescript
describe('UserService', () => {
  let service: UserService;
  let httpMock: HttpTestingController;

  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [provideHttpClient(), provideHttpClientTesting()]
    });
    service = TestBed.inject(UserService);
    httpMock = TestBed.inject(HttpTestingController);
  });

  it('should fetch users', () => {
    const mockUsers = [{ id: '1', name: 'Alice' }];
    service.getUsers().subscribe(users => {
      expect(users).toEqual(mockUsers);
    });
    httpMock.expectOne('/api/users').flush(mockUsers);
  });
});
```

## Testing Signals
```typescript
it('should compute total from items', () => {
  const service = TestBed.inject(CartService);
  service.add({ id: '1', price: 10, qty: 2 });
  service.add({ id: '2', price: 5, qty: 1 });
  expect(service.total()).toBe(25);
});
```
