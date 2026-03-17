# Review Round Details

Expanded guidance for each review round in the canonical review process.

## Round 0 — Spec Alignment

The goal of Round 0 is to verify the implementation **matches the initiative specs**.

### reviewer-code checks:
- Match implementation against PRD requirements and acceptance criteria in `product/prd.md`
- Verify architecture follows `engineering/plan.md` — components, data flow, state management
- Check design spec adherence — layout, interactions, responsive behavior
- Flag unspecified behavior — code that exists but isn't described in any spec
- Flag missing features — spec requirements with no corresponding implementation
- If no initiative folder or specs exist, skip this round and note it in the report

## Round 1 — Functional

The goal of Round 1 is to verify that the change **works correctly** and does what it claims.

### eng-testing checks:
- Run the full test suite — all tests must pass
- Check coverage delta — did the change add tests for new code paths?
- Identify new untested paths — are there branches, error cases, or edge cases without test coverage?
- Verify test quality — are tests testing behavior (not implementation details)?

### reviewer-code checks:
- **Logic correctness**: Does the code do what the PR description says it does?
- **Edge cases**: What happens with empty inputs, null values, boundary conditions, concurrent access?
- **Error handling**: Are errors caught, propagated correctly, and surfaced to the user appropriately?
- **Data flow**: Does data move correctly through the system? Are transformations correct?
- **Regression risk**: Could this change break existing functionality?

## Round 2 — Quality

The goal of Round 2 is to verify that the change is **well-crafted** and maintainable.

### reviewer-code checks:
- **Naming**: Are variables, functions, and classes named clearly and consistently?
- **DRY**: Is there duplicated logic that should be extracted?
- **SOLID principles**: Single responsibility, open/closed, interface segregation
- **Idiomatic patterns**: Does the code follow the language and framework conventions?
- **Security anti-patterns**: Hardcoded secrets, SQL injection, XSS, unsafe deserialization, missing auth checks
- **Error propagation**: Are errors swallowed silently? Are error messages helpful?

### eng-performance checks (if available):
- **Bundle size delta**: Does this change significantly increase the bundle?
- **Render count**: Are there unnecessary re-renders in UI components?
- **Query count**: Are there N+1 queries or unnecessary database round trips?
- **Unnecessary computation**: Are expensive operations cached or memoized when appropriate?
- **Memory**: Are there potential memory leaks (event listeners, subscriptions, large objects held in closures)?

### reviewer-architecture checks (if available):
- **Component boundaries**: Are responsibilities correctly separated?
- **Dependency direction**: Do dependencies flow in the right direction (high-level → low-level)?
- **Abstraction level**: Is the abstraction level appropriate — not too much, not too little?
- **API surface area**: Is the public API minimal and well-designed?
- **Consistency**: Does the architecture match established patterns in the codebase?

## Round 3 — Compliance

The goal of Round 3 is to verify **regulatory, accessibility, content, and brand compliance**.

### compliance checks (if available):
- **GDPR data handling**: Is personal data collected, stored, and processed correctly?
- **Consent flows**: Are consent mechanisms present where required?
- **Data retention**: Is data retained only as long as needed?
- **WCAG contrast**: Do color combinations meet AA contrast ratios (4.5:1 text, 3:1 large text)?
- **WCAG keyboard**: Can all interactive elements be reached and operated via keyboard?
- **WCAG screen reader**: Are ARIA labels, roles, and live regions used correctly?

### reviewer-content checks (if available):
- **Meta tags**: Are title, description, and Open Graph tags present and correct?
- **Schema markup**: Is structured data (JSON-LD) present for relevant content?
- **Content accuracy**: Is user-facing text accurate and free of errors?
- **Link validity**: Do all links point to valid destinations?

### positioning checks (if available):
- **Messaging alignment**: Does user-facing copy align with the product positioning?
- **Terminology consistency**: Are product terms used consistently across the change?
- **Value prop reinforcement**: Does the change reinforce (or at least not contradict) the core value proposition?
