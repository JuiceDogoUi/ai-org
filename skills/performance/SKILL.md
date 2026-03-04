---
name: performance
description: Performance profiling, algorithmic complexity, bundle optimization, and runtime efficiency patterns. Use when analyzing or improving application performance.
user-invocable: false
---

# Performance Engineering

> **Documentation Freshness**: Web Vitals metrics and thresholds evolve — check
> web.dev/vitals for current targets. Browser APIs (Performance Observer, Navigation
> Timing) change across versions; verify on MDN.

## File Guide
- **optimization.md** — Code splitting, rendering, image, caching, and memory optimization patterns
- **profiling.md** — Browser profiling, Web Vitals tracking, database query profiling, bundle analysis

## Core Principle

Measure first, then optimize. Never optimize without data. Complexity impacts performance
when it adds overhead or hides bottlenecks on critical paths.

## Profiling Approach

1. **Measure baseline** — record numbers, not impressions
2. **Identify bottlenecks** — focus on critical path, what users experience
3. **Prioritize by impact** — effort-to-improvement ratio determines order
4. **Verify improvement** — same measurement method, before and after

## Runtime Performance

### Database
```sql
-- Use EXPLAIN ANALYZE to understand query performance
EXPLAIN ANALYZE SELECT * FROM orders WHERE user_id = 'abc';

-- Look for:
-- - Seq Scan on large tables (add index)
-- - Nested Loop with high row counts (consider hash join)
-- - High actual vs estimated rows (update statistics)
```

### Common Issues
- **N+1 queries**: Fetch related data in batch
- **Missing indexes**: Add indexes for WHERE, JOIN, ORDER BY
- **Unbounded queries**: Always paginate, set limits
- **Connection exhaustion**: Use connection pooling

### Memory
- Unbounded caches (set max size, TTL)
- Leaked event listeners (remove on cleanup)
- Growing closures (avoid capturing large scopes)
- Large object retention (release references)

### Computation
- Repeated parsing (parse once, cache result)
- Redundant serialization (serialize at boundaries only)
- Hot path inefficiencies (optimize most-called code)
- Synchronous blocking (use async for I/O)

## Frontend Performance

### Core Web Vitals
| Metric | Target | What It Measures |
|--------|--------|------------------|
| LCP | < 2.5s | Largest Contentful Paint (loading) |
| INP | < 200ms | Interaction to Next Paint (responsiveness) |
| CLS | < 0.1 | Cumulative Layout Shift (visual stability) |

### Bundle Optimization
```javascript
// Code splitting - load on demand
const HeavyComponent = lazy(() => import('./HeavyComponent'));

// Tree shaking - import only what you use
import { debounce } from 'lodash-es'; // Not: import _ from 'lodash'
```

### Rendering
- **Layout thrashing**: Batch DOM reads, then writes
- **Excessive re-renders**: Memoize components, use proper keys
- **Large DOM**: Virtualize long lists
- **Heavy paints**: Use `transform` and `opacity` for animations

### Assets
- Modern formats: WebP/AVIF for images
- Lazy loading: `loading="lazy"` for below-fold images
- Preload critical: `<link rel="preload">` for fonts, hero images
- Responsive images: `srcset` for appropriate sizes

## Network Performance

### Waterfall Optimization
- Eliminate serial chains (parallelize requests)
- Preload critical resources
- Use HTTP/2 or HTTP/3 for multiplexing
- Minimize redirects

### Caching
```
Cache-Control: public, max-age=31536000, immutable  # Static assets with hash
Cache-Control: private, max-age=0, must-revalidate  # Dynamic content
```

### Compression
- Enable gzip/brotli for text assets
- Already-compressed formats (JPEG, PNG) don't benefit
- Compress API responses

### Payload
- Paginate large collections
- Support field selection (GraphQL or sparse fieldsets)
- Avoid over-fetching and under-fetching

## Algorithmic Complexity

### Big O Awareness
| Complexity | Example | Watch For |
|------------|---------|-----------|
| O(1) | Hash lookup | Ideal for hot paths |
| O(log n) | Binary search | Sorted data operations |
| O(n) | Linear scan | Acceptable for small n |
| O(n log n) | Good sorting | Sorts, priority queues |
| O(n²) | Nested loops | Red flag on hot paths |
| O(2ⁿ) | Naive recursion | Almost always wrong |

### Data Structure Selection
- **Lookup by key**: Map/Object, not Array.find()
- **Uniqueness**: Set, not Array with includes()
- **Sorted access**: Sorted array or tree
- **Queue operations**: Actual queue, not array shift()

### Memoization
```javascript
// Cache expensive computations
const memoizedFn = useMemo(() => expensiveComputation(input), [input]);
```

For manual caching, use a Map-based cache-aside pattern with TTL and bounded size. See **optimization.md** for implementation patterns.

## Measurement Tools

### Profiling
- **Browser**: Chrome DevTools Performance tab
- **Node.js**: `--inspect` with Chrome DevTools, clinic.js
- **Mobile**: Xcode Instruments, Android Profiler

### Bundle Analysis
- webpack-bundle-analyzer
- source-map-explorer
- bundlephobia.com for package size

### Database
- `EXPLAIN ANALYZE` (PostgreSQL)
- Slow query logs
- APM tools (Datadog, New Relic)

### Custom Timing
```javascript
performance.mark('start-operation');
await doExpensiveWork();
performance.mark('end-operation');
performance.measure('operation', 'start-operation', 'end-operation');
```

## Avoid

- **Premature optimization** — Measure first; most code isn't performance-critical
- **Micro-benchmarks** — Measure real workloads, not synthetic tests
- **Optimizing cold paths** — Focus on hot paths users actually hit
- **Ignoring algorithmic complexity** — O(n²) can't be fixed with faster hardware
- **Over-caching** — Caches add complexity; cache what's measured slow
- **Synchronous I/O on main thread** — Always async for network, disk, database
- **Blocking event loop** — Long tasks cause jank; break up or use workers
- **Guessing bottlenecks** — Profile to find actual bottlenecks
- **One-size-fits-all solutions** — Different problems need different solutions
- **Sacrificing readability first** — Optimize only when measured and necessary
