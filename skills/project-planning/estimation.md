# Estimation Techniques

## T-Shirt Sizing
| Size | Description | Relative Effort |
|------|------------|----------------|
| S | Single file, clear change, no dependencies | 1x |
| M | 2-5 files, some complexity, known approach | 2-3x |
| L | Multiple files, cross-cutting, needs design | 5-8x |
| XL | Multiple systems, unknown scope, needs research | 13x+ |

## Estimation Process
1. Understand the requirement (ask questions if unclear)
2. Identify what needs to change (files, systems, APIs)
3. Compare to past work of known size
4. Account for unknowns (add buffer for uncertainty)
5. Break XL items down -- if you can't, it needs more research

## Common Estimation Mistakes
- Forgetting about testing effort
- Ignoring deployment and configuration
- Assuming no code review iterations
- Not accounting for context switching
- Estimating best-case instead of likely-case
