---
name: performance
description: Performance profiling, bundle analysis, Core Web Vitals, query optimization, and memory leak detection patterns. Use when analyzing or improving application performance.
user-invocable: false
---

# Performance Engineering

## Profiling Approach
1. **Measure baseline** before any changes (record numbers, not impressions)
2. **Identify bottlenecks** on the critical path -- focus on what users experience
3. **Prioritize by impact** -- effort-to-improvement ratio determines order
4. **Verify improvement** with the same measurement after the fix

## Frontend Performance
- **Core Web Vitals**: LCP < 2.5s, INP < 200ms, CLS < 0.1
- **Bundle size**: Track total JS shipped, use code splitting for routes
- **Rendering**: Avoid layout thrashing, minimize DOM size, debounce resize/scroll
- **Images**: Use modern formats (WebP/AVIF), responsive `srcset`, lazy loading
- **Caching**: Set appropriate `Cache-Control` headers, use content hashing for assets

## Backend Performance
- **Database**: Use EXPLAIN for query plans, add indexes for frequent queries, avoid N+1
- **Concurrency**: Use connection pooling, batch operations, async I/O
- **Memory**: Watch for unbounded caches, leaked event listeners, growing closures
- **Serialization**: Avoid repeated parsing, use streaming for large payloads

## Network
- **Waterfall**: Eliminate serial request chains, preload critical resources
- **Compression**: Enable gzip/brotli for text assets
- **HTTP/2+**: Multiplexing eliminates need for domain sharding
- **CDN**: Cache static assets at the edge

## Measurement Tools
- Browser DevTools Performance tab / Lighthouse
- `performance.mark()` and `performance.measure()` for custom timings
- Server-side APM (traces, spans, slow query logs)
- `EXPLAIN ANALYZE` for database query plans

For profiling patterns, see [profiling.md](profiling.md).
For optimization patterns, see [optimization.md](optimization.md).
