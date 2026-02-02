# Funnel Analysis Framework

A systematic approach to analyzing user conversion funnels.

## Defining the Funnel

### Step 1: Identify the Goal

What is the desired outcome? Examples:
- Purchase completed
- Account created and activated
- Feature adopted (used 3+ times)
- Content published

### Step 2: Map the Steps

List every step a user takes from entry to goal. Be specific:

```
Landing page → Signup form → Email verification → Onboarding wizard → First action → Goal
```

### Step 3: Define Events

For each step, define the exact event or condition that marks completion:

| Step | Event | Definition |
|------|-------|-----------|
| Visit | page_view | User loads the landing page |
| Signup start | form_focused | User interacts with signup form |
| Signup complete | account_created | Account record created in database |
| Activation | first_value_action | User completes the core action once |

## Measuring Conversion

### Step-to-Step Conversion Rate

```
Conversion rate (Step N → N+1) = Users completing Step N+1 / Users completing Step N × 100%
```

### Overall Funnel Conversion

```
Overall conversion = Users completing final step / Users entering first step × 100%
```

### Time-to-Convert

Measure how long users take between steps. Long delays between steps may indicate friction or confusion.

## Diagnosing Drop-offs

When a step shows significant drop-off:

1. **Quantify the drop** — what percentage of users leave at this step?
2. **Segment the drop** — do specific user groups drop off more?
3. **Analyze behavior** — what do users who drop off do instead? (rage clicks, back navigation, idle time)
4. **Hypothesize causes**:
   - **Friction**: too many fields, slow load, confusing UI
   - **Motivation**: value not clear, price objection, trust issue
   - **Technical**: errors, broken flows, compatibility issues
5. **Prioritize fixes** by drop-off magnitude × estimated fix impact

## Segmentation Approaches

Slice funnel data by:

- **Acquisition channel**: organic vs paid vs referral
- **Device type**: mobile vs desktop
- **Geography**: country or region
- **User type**: new vs returning
- **Plan/tier**: free vs paid
- **Cohort**: signup week or month

Different segments often have dramatically different conversion rates, revealing specific opportunities.

## Reporting Template

```
## Funnel: [Name]
**Period**: [Date range]
**Total entries**: [N]
**Overall conversion**: [X%]

### Step-by-Step Breakdown

| Step | Users | Conversion | Drop-off | Δ vs Previous Period |
|------|-------|-----------|----------|---------------------|
| ... | ... | ... | ... | ... |

### Key Drop-off: [Step Name]
- Drop-off rate: [X%]
- Primary segments affected: [list]
- Hypothesized causes: [list]
- Recommended actions: [list]
```
