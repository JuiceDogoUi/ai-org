# A/B Test Planning Template

Use this template to plan rigorous A/B tests with clear hypotheses, metrics, and analysis plans.

## Test Plan

```
## Test: [Name]
**Owner**: [who]
**Status**: Planning / Running / Analyzing / Complete

### Hypothesis
If we [change], then [metric] will [improve/decrease] by [minimum detectable effect]
because [reasoning].

### Variants
| Variant | Description |
|---------|-------------|
| Control (A) | Current experience — [describe] |
| Treatment (B) | Changed experience — [describe] |

### Metrics

**Primary metric** (one only):
- Metric: [name]
- Definition: [exact calculation]
- Current baseline: [value]
- Minimum detectable effect (MDE): [X%]
- Direction: [increase / decrease]

**Secondary metrics** (2-3):
- [Metric name]: [definition] — helps explain primary metric movement

**Guardrail metrics** (1-2):
- [Metric name]: [definition] — must NOT degrade beyond [threshold]

### Sample Size & Duration

- Required sample per variant: [N]
- Statistical significance level: 95% (α = 0.05)
- Statistical power: 80% (β = 0.20)
- Expected daily traffic: [N users/day]
- Estimated duration: [N days/weeks]
- Minimum duration: [N days] (to capture weekly cycles)

### Targeting
- Eligible users: [criteria]
- Randomization unit: [user / session / device]
- Traffic allocation: [50/50 or other split]
- Exclusions: [any users to exclude]

### Analysis Plan
1. Check sample ratio mismatch (SRM) — variants should have equal-ish sizes
2. Check guardrail metrics — abort if degraded beyond threshold
3. Evaluate primary metric — is the difference statistically significant?
4. Evaluate secondary metrics — do they explain the primary result?
5. Segment analysis — does the effect vary by user segment?
6. Decision: Ship / Iterate / Abandon

### Risks & Considerations
- [Novelty effect: new UI may temporarily boost engagement]
- [Seasonal factors: holiday traffic may skew results]
- [Interaction effects: other running tests that may interfere]
```

## Sample Size Calculation Guide

For a two-proportion z-test (typical for conversion rate tests):

| Baseline Rate | MDE (Relative) | Sample per Variant (approx.) |
|---------------|----------------|------------------------------|
| 1% | 20% | ~195,000 |
| 5% | 10% | ~30,000 |
| 10% | 5% | ~31,000 |
| 20% | 5% | ~12,500 |
| 50% | 2% | ~19,000 |

These assume α = 0.05, power = 80%, two-tailed test.

## Common Pitfalls

- **Peeking**: Checking results before reaching sample size inflates false positive rate
- **P-hacking**: Running multiple tests and only reporting significant results
- **Underpowered tests**: Too small a sample to detect real effects
- **Ignoring segments**: Overall neutral results may hide segment-specific effects
- **Short duration**: Missing weekly or monthly cycles in user behavior
- **Multiple comparisons**: Testing many metrics without correction increases false positives
