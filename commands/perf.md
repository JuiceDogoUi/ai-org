---
name: perf
description: Performance analysis and optimization recommendations
argument-hint: "[target or area to analyze]"
context: fork
agent: eng-performance
---

Analyze performance of: $ARGUMENTS

## Process

1. Profile the target area (bundle size, rendering, queries, etc.)
2. Identify bottlenecks with evidence
3. Measure or estimate current metrics
4. Recommend optimizations with expected impact

## Output Format

### Current State
Metrics and observations about current performance.

### Bottlenecks
Ranked list of performance issues with evidence.

### Recommendations
| Issue | Fix | Expected Impact | Effort |
|-------|-----|----------------|--------|

Prioritized by effort-to-impact ratio.
