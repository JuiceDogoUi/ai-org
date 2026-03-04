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

Debounce expensive operations — clear and reset a `setTimeout` on each call. Use a library like `lodash-es/debounce` if available.

```html
<!-- Virtual scrolling for large lists (Angular CDK) -->
<cdk-virtual-scroll-viewport itemSize="48" class="list">
  <div *cdkVirtualFor="let item of items" class="item">
    {{ item.name }}
  </div>
</cdk-virtual-scroll-viewport>
```

```typescript
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

Use JOINs, IN clauses, or eager loading to batch related data fetches. See the `database-design` skill for SQL patterns and examples.

### Caching Patterns

**Cache-aside with TTL**: Check cache first; on miss, load from source, store with expiration. Use a `Map<string, { value: T; expires: number }>` or a library like `node-cache` or `lru-cache`.

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
```

Bound LRU caches with a max size — use a `Map` where `get` re-inserts to maintain recency, and `set` evicts the oldest entry when full. For production use, consider `lru-cache` from npm.
