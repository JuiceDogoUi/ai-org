---
name: research
description: Deep research on a topic with synthesis
argument-hint: "[topic to research]"
context: fork
agent: researcher
---

Conduct thorough research on: $ARGUMENTS

**Fallback**: If web search is unavailable, research from existing project files, strategy documents, codebase patterns, and inline documentation instead.

## Process

1. Search for relevant information across available sources
2. Read and analyze relevant codebase files if applicable
3. Cross-reference multiple sources for accuracy
4. Synthesize findings into a structured report

## Output

### Summary
Key findings in 3-5 bullet points.

### Detailed Findings
Organized by subtopic with evidence and sources.

### Recommendations
Specific, actionable next steps based on findings.

### Sources
List all sources referenced.

> Related: `/prd` to turn findings into requirements, `/plan` to create an implementation plan, `/feature` for the full product workflow.
