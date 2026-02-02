# Source Evaluation Framework

A systematic framework for evaluating the credibility and usefulness of research sources.

## RAMBA Criteria

Evaluate every source against five dimensions:

### Recency

- **When was it published or last updated?**
- Technology sources: treat anything older than 2 years as potentially outdated
- Business/market sources: treat anything older than 1 year as potentially outdated
- Foundational concepts (design patterns, algorithms): age matters less
- Always check for more recent versions or updates

### Authority

- **Who created this? Are they credible in this domain?**
- Institutional affiliation (university, major company, standards body)
- Author's track record and expertise
- Publication venue (peer-reviewed journal vs personal blog)
- Community recognition (citations, references by other credible sources)

### Methodology

- **How was the information gathered?**
- Is the methodology described and reproducible?
- Sample size and selection (for studies and surveys)
- Data collection methods and potential for error
- Statistical rigor (for quantitative claims)
- Are limitations acknowledged?

### Bias

- **Does the source have a vested interest in a particular conclusion?**
- Commercial bias: vendor whitepapers promoting their own products
- Ideological bias: advocacy organizations pushing a specific agenda
- Selection bias: cherry-picked data or examples
- Survivorship bias: only reporting successes
- Funding source: who paid for the research?

### Applicability

- **Is this relevant to our specific context?**
- Does the source's context match ours (scale, industry, technology)?
- Are findings generalizable or specific to a narrow situation?
- Does the source address our specific question or a related but different one?

## Classification Template

For each key source, record:

```
Source: [Title/URL]
Type: Primary / Secondary / Tertiary
Recency: [Date] — Current / Aging / Outdated
Authority: High / Medium / Low — [reason]
Methodology: Described / Partial / None
Bias risk: Low / Medium / High — [type of bias]
Applicability: Direct / Adjacent / Tangential
Overall credibility: High / Medium / Low
```

## Primary vs Secondary Sources

| Type | Definition | Examples | When to use |
|------|-----------|----------|-------------|
| Primary | Original data or firsthand account | Official docs, source code, original research, API specs | Always prefer for technical facts |
| Secondary | Analysis or interpretation of primary sources | Review articles, tutorials, comparison posts | For synthesis and context |
| Tertiary | Aggregation of secondary sources | Wikipedia, textbooks, encyclopedia entries | For background orientation only |
