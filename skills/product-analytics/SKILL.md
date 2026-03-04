---
name: product-analytics
description: Funnel analysis, A/B testing methodology, metrics frameworks, and data-driven product decisions
user-invocable: false
---

# Product Analytics

> **Documentation Freshness**: Analytics platforms, experimentation tools, and privacy
> regulations evolve. Check your analytics platform documentation for current APIs,
> and verify statistical methods against current best practices.

## File Guide
- **funnel-analysis.md** — Funnel analysis framework and diagnostic methodology
- **ab-test-template.md** — A/B test planning template with hypothesis, metrics, and analysis plan

Conventions for data-driven product analysis and experimentation.

## Metrics Frameworks

### AARRR (Pirate Metrics)

| Stage | Metric | Question |
|-------|--------|----------|
| Acquisition | New users/visitors | How do users find us? |
| Activation | First value moment | Do users have a good first experience? |
| Retention | Return usage | Do users come back? |
| Revenue | Monetization | Do users pay? |
| Referral | Organic growth | Do users tell others? |

### North Star Metric

Every product should identify a single north star metric that:

- Reflects the core value delivered to users
- Correlates with long-term revenue
- Is actionable (teams can influence it)
- Is measurable with reasonable effort

Examples: Slack → messages sent per team per week. Airbnb → nights booked.

## Funnel Analysis

Analyze user flows as sequential steps with conversion rates between each.

1. **Define the funnel** — what are the key steps from entry to goal?
2. **Measure conversion** — what percentage of users move from step N to step N+1?
3. **Diagnose drop-offs** — where are the biggest drops and why?
4. **Segment** — do different user segments behave differently?

See [Funnel Analysis](funnel-analysis.md) for the full framework.

## A/B Testing

Rigorous experimentation requires:

1. **Clear hypothesis** — "Changing X will improve Y because Z"
2. **Success metric** — one primary metric, plus secondary and guardrail metrics
3. **Sample size calculation** — based on minimum detectable effect and statistical power
4. **Duration** — long enough for statistical significance AND to capture weekly patterns
5. **Analysis plan** — pre-registered to avoid p-hacking

See [A/B Test Template](ab-test-template.md) for the planning template.

## Cohort Analysis

Group users by a shared characteristic (signup date, acquisition channel, plan type) and track behavior over time. Use cohort analysis for:

- **Retention curves** — do users stick around? Is retention improving over time?
- **Feature adoption** — which cohorts adopt new features?
- **Revenue patterns** — how does lifetime value develop by cohort?

## Dashboard Design Principles

- **One primary metric per dashboard** — everything else supports context
- **Compare to benchmarks** — show targets, previous periods, or segments
- **Make trends visible** — time series over point-in-time values
- **Segment by default** — break down by user type, plan, geography
- **Actionable, not decorative** — every chart should inform a decision

## Avoid

- **Vanity metrics** — Track metrics that drive decisions, not ego (users registered ≠ active users)
- **P-hacking** — Pre-register hypotheses; don't mine data for significance
- **Underpowered tests** — Calculate sample size before starting; stop when planned
- **Ignoring guardrail metrics** — Feature wins shouldn't come at the cost of core metrics
- **Confusing correlation with causation** — Experiments prove causation; analytics show correlation
- **Segment cherry-picking** — If you must segment post-hoc, adjust significance thresholds
- **Survivorship bias** — Include churned users in retention analysis
- **Weekly patterns in short tests** — Run experiments at least 2 weeks to capture weekly variance
- **Dashboard overload** — Too many metrics = no focus; ruthlessly prioritize
- **Data without action** — Every metric should have a clear owner and response plan
