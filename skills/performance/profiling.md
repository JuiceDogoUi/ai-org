# Profiling Patterns

## Browser Profiling
```javascript
// Mark critical user interactions
performance.mark('search-start');
// ... operation ...
performance.mark('search-end');
performance.measure('search', 'search-start', 'search-end');

// Log slow operations
const entries = performance.getEntriesByType('measure');
entries.filter(e => e.duration > 100).forEach(e => {
  console.warn(`Slow operation: ${e.name} took ${e.duration}ms`);
});
```

## Web Vitals Tracking
```javascript
// Largest Contentful Paint
new PerformanceObserver(list => {
  const entries = list.getEntries();
  const lcp = entries[entries.length - 1];
  console.log('LCP:', lcp.startTime);
}).observe({ type: 'largest-contentful-paint', buffered: true });

// Interaction to Next Paint
new PerformanceObserver(list => {
  for (const entry of list.getEntries()) {
    if (entry.interactionId) {
      console.log('INP candidate:', entry.duration);
    }
  }
}).observe({ type: 'event', buffered: true });
```

## Database Query Profiling

### PostgreSQL
```sql
-- Enable timing
\timing on

-- Analyze query plan with actual execution
EXPLAIN (ANALYZE, BUFFERS, FORMAT TEXT)
SELECT u.name, COUNT(o.id)
FROM users u
LEFT JOIN orders o ON o.user_id = u.id
WHERE u.created_at > NOW() - INTERVAL '30 days'
GROUP BY u.id;

-- Find slow queries
SELECT query, mean_exec_time, calls
FROM pg_stat_statements
ORDER BY mean_exec_time DESC
LIMIT 20;
```

### MySQL
```sql
-- Analyze query plan
EXPLAIN ANALYZE
SELECT u.name, COUNT(o.id)
FROM users u
LEFT JOIN orders o ON o.user_id = u.id
WHERE u.created_at > NOW() - INTERVAL 30 DAY
GROUP BY u.id;

-- Find slow queries
SELECT * FROM performance_schema.events_statements_summary_by_digest
ORDER BY avg_timer_wait DESC
LIMIT 20;
```

## Memory Leak Detection

### Node.js
- Use `v8.writeHeapSnapshot()` to capture heap snapshots for comparison
- Track `process.memoryUsage()` over time (RSS and heap) to detect growth
- Use `--inspect` flag with Chrome DevTools Memory tab for visual analysis

### Browser
- DevTools → Memory → Take heap snapshot
- Compare snapshots: look for growing object counts
- Common leaks: detached DOM nodes, forgotten event listeners, closures over large scope

## Bundle Analysis
```bash
# Webpack
npx webpack-bundle-analyzer dist/stats.json

# Vite / Rollup
npx rollup-plugin-visualizer

# Angular
ng build --stats-json && npx webpack-bundle-analyzer dist/*/stats.json

# Generic: check gzipped sizes
find dist -name "*.js" -exec sh -c 'echo "$(gzip -c "$1" | wc -c) $1"' _ {} \; | sort -rn
```
