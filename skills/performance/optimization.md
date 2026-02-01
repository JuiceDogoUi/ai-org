# Optimization Patterns

## Frontend

### Code Splitting
```typescript
// Route-level splitting (Angular)
const routes: Routes = [
  {
    path: 'dashboard',
    loadComponent: () => import('./dashboard/dashboard.component')
      .then(m => m.DashboardComponent)
  }
];

// Dynamic import for heavy libraries
async function renderChart(data: ChartData) {
  const { Chart } = await import('chart.js');
  return new Chart(canvas, { data });
}
```

### Rendering Performance
```typescript
// Debounce expensive operations
function debounce<T extends (...args: any[]) => void>(fn: T, ms: number): T {
  let timer: ReturnType<typeof setTimeout>;
  return ((...args: any[]) => {
    clearTimeout(timer);
    timer = setTimeout(() => fn(...args), ms);
  }) as T;
}

// Virtual scrolling for large lists (Angular CDK)
<cdk-virtual-scroll-viewport itemSize="48" class="list">
  <div *cdkVirtualFor="let item of items" class="item">
    {{ item.name }}
  </div>
</cdk-virtual-scroll-viewport>

// Avoid layout thrashing: batch reads, then batch writes
const heights = elements.map(el => el.offsetHeight); // batch read
elements.forEach((el, i) => {
  el.style.height = `${heights[i] * 2}px`; // batch write
});
```

### Image Optimization
```html
<!-- Responsive images with modern formats -->
<picture>
  <source srcset="hero.avif" type="image/avif">
  <source srcset="hero.webp" type="image/webp">
  <img src="hero.jpg" alt="Hero" loading="lazy"
       width="1200" height="600"
       srcset="hero-400.jpg 400w, hero-800.jpg 800w, hero-1200.jpg 1200w"
       sizes="(max-width: 600px) 400px, (max-width: 1000px) 800px, 1200px">
</picture>
```

## Backend

### Database Query Optimization
```sql
-- Add covering index to avoid table lookups
CREATE INDEX idx_orders_user_status
ON orders (user_id, status)
INCLUDE (total, created_at);

-- Use batch inserts instead of individual
INSERT INTO events (type, user_id, created_at)
VALUES
  ('login', 1, NOW()),
  ('login', 2, NOW()),
  ('login', 3, NOW());

-- Pagination with cursor (not OFFSET)
SELECT id, name, created_at
FROM products
WHERE created_at < :last_seen_created_at
ORDER BY created_at DESC
LIMIT 20;
```

### N+1 Query Elimination
```typescript
// BAD: N+1 queries
const users = await db.query('SELECT * FROM users LIMIT 100');
for (const user of users) {
  user.orders = await db.query('SELECT * FROM orders WHERE user_id = ?', [user.id]);
}

// GOOD: Batch load with IN clause
const users = await db.query('SELECT * FROM users LIMIT 100');
const userIds = users.map(u => u.id);
const orders = await db.query('SELECT * FROM orders WHERE user_id IN (?)', [userIds]);
const ordersByUser = groupBy(orders, 'user_id');
users.forEach(u => u.orders = ordersByUser[u.id] || []);
```

### Caching Patterns
```typescript
// Cache-aside pattern with TTL
class CacheAside<T> {
  constructor(
    private cache: Map<string, { value: T; expires: number }>,
    private ttlMs: number
  ) {}

  async get(key: string, loader: () => Promise<T>): Promise<T> {
    const cached = this.cache.get(key);
    if (cached && cached.expires > Date.now()) {
      return cached.value;
    }
    const value = await loader();
    this.cache.set(key, { value, expires: Date.now() + this.ttlMs });
    return value;
  }
}
```

### Connection Pooling
```typescript
// Use pool instead of individual connections
import { Pool } from 'pg';

const pool = new Pool({
  max: 20,              // max concurrent connections
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 2000,
});

// Connections are returned to pool automatically
const result = await pool.query('SELECT * FROM users WHERE id = $1', [userId]);
```

## Memory

### Preventing Leaks
```typescript
// Always clean up subscriptions
class MyComponent implements OnDestroy {
  private destroy$ = new Subject<void>();

  ngOnInit() {
    this.dataService.stream$
      .pipe(takeUntil(this.destroy$))
      .subscribe(data => this.render(data));
  }

  ngOnDestroy() {
    this.destroy$.next();
    this.destroy$.complete();
  }
}

// Use WeakMap/WeakRef for caches keyed by objects
const metadata = new WeakMap<Element, Metadata>();

// Bound size for LRU caches
class LRUCache<K, V> {
  private map = new Map<K, V>();
  constructor(private maxSize: number) {}

  get(key: K): V | undefined {
    const value = this.map.get(key);
    if (value !== undefined) {
      this.map.delete(key);
      this.map.set(key, value);
    }
    return value;
  }

  set(key: K, value: V): void {
    this.map.delete(key);
    this.map.set(key, value);
    if (this.map.size > this.maxSize) {
      const oldest = this.map.keys().next().value;
      this.map.delete(oldest);
    }
  }
}
```
