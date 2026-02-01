# Angular Component Patterns

## Standalone Component
```typescript
@Component({
  selector: 'app-user-card',
  standalone: true,
  imports: [CommonModule, RouterLink],
  changeDetection: ChangeDetectionStrategy.OnPush,
  template: `
    <div class="user-card">
      <h3>{{ user().name }}</h3>
      <p>{{ user().email }}</p>
    </div>
  `
})
export class UserCardComponent {
  user = input.required<User>();
}
```

## Signal-Based State Management
```typescript
@Injectable({ providedIn: 'root' })
export class CartService {
  private items = signal<CartItem[]>([]);

  readonly count = computed(() => this.items().length);
  readonly total = computed(() =>
    this.items().reduce((sum, item) => sum + item.price * item.qty, 0)
  );

  add(item: CartItem): void {
    this.items.update(items => [...items, item]);
  }
}
```

## Smart/Dumb Component Pattern
```typescript
// Smart (container) -- fetches data, handles actions
@Component({ /* ... */ })
export class UserListPageComponent {
  private userService = inject(UserService);
  users = toSignal(this.userService.getUsers());

  onDelete(id: string): void {
    this.userService.delete(id).subscribe();
  }
}

// Dumb (presentational) -- receives data via inputs
@Component({ /* ... */ })
export class UserListComponent {
  users = input.required<User[]>();
  delete = output<string>();
}
```

## Route with Resolver
```typescript
export const routes: Routes = [
  {
    path: 'users/:id',
    component: UserDetailComponent,
    resolve: { user: userResolver }
  }
];

export const userResolver: ResolveFn<User> = (route) => {
  return inject(UserService).getById(route.paramMap.get('id')!);
};
```
