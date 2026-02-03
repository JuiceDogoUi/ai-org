---
name: technical-writing
description: Technical writing principles, API documentation, README structure, and developer guides. Use when writing documentation, READMEs, or technical guides.
user-invocable: false
---

# Technical Writing

## Core Principles

- Write for the reader's goal, not the author's knowledge
- Lead with the most important information
- Use short paragraphs (3-4 sentences max)
- Use active voice: "The function returns" not "A value is returned"
- Use consistent terminology — define terms once, use them consistently
- Include code examples for every API or concept

## Document Structure

1. **What** it is (1-2 sentences)
2. **Why** you'd use it (motivation)
3. **How** to use it (quick example)
4. **Reference** (complete details)

## README Structure

```markdown
# Project Name

One-paragraph description of what this project does and who it's for.

## Quick Start

\`\`\`bash
npm install my-project
\`\`\`

\`\`\`javascript
import { thing } from 'my-project';
thing.doSomething();
\`\`\`

## Features

- Feature one: Brief description
- Feature two: Brief description

## Installation

Detailed installation instructions with prerequisites.

## Usage

### Basic Usage
Code example with explanation.

### Configuration
Configuration options in a table or list.

### Advanced Usage
More complex examples.

## API Reference

Link to detailed API docs or include inline.

## Contributing

How to contribute, where to file issues.

## License

License type and link.
```

## API Documentation

### Function Documentation
```javascript
/**
 * Creates a new user account.
 *
 * @param {Object} userData - The user data
 * @param {string} userData.email - User's email address
 * @param {string} userData.name - User's display name
 * @param {string} [userData.role='user'] - User's role (optional)
 * @returns {Promise<User>} The created user object
 * @throws {ValidationError} If email is invalid
 * @throws {ConflictError} If email already exists
 *
 * @example
 * const user = await createUser({
 *   email: 'alice@example.com',
 *   name: 'Alice'
 * });
 * console.log(user.id); // 'usr_abc123'
 */
```

### REST API Documentation
```markdown
## Create User

Creates a new user account.

### Request

`POST /api/users`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| email | string | Yes | User's email address |
| name | string | Yes | User's display name |
| role | string | No | User's role (default: "user") |

### Response

**Success (201 Created)**
\`\`\`json
{
  "data": {
    "id": "usr_abc123",
    "email": "alice@example.com",
    "name": "Alice"
  }
}
\`\`\`

**Error (400 Bad Request)**
\`\`\`json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid email format"
  }
}
\`\`\`
```

## Code Examples

### Guidelines
- Show the minimal working example first
- Use realistic variable names, not `foo`/`bar`
- Include expected output where helpful
- Test all code examples before publishing
- Show both basic and advanced usage

### Structure
```javascript
// Good: Context, then code, then result
// Connect to the database
const db = await connect('postgres://localhost/mydb');

// Query for active users
const users = await db.query('SELECT * FROM users WHERE active = true');

// Result: Array of user objects
// [{ id: 1, name: 'Alice', active: true }, ...]
```

## Writing Style

### Voice
- **Active**: "The function returns a promise" (not "A promise is returned")
- **Direct**: "Use `config.json` to configure" (not "Configuration can be done via")
- **Present tense**: "This method creates" (not "This method will create")

### Sentence Structure
- Start with the action or subject
- One idea per sentence
- Front-load important information
- Use lists for multiple items

### Word Choice
- Use simple words: "use" not "utilize", "start" not "initialize"
- Be specific: "returns `null`" not "returns an empty value"
- Define acronyms on first use: "CLI (Command Line Interface)"

## Formatting

### Headings
- Use title case for H1, sentence case for H2+
- Keep headings short and descriptive
- Use parallel structure (all verbs or all nouns)

### Code
- Inline code for: function names, file names, values, short code
- Code blocks for: multi-line examples, command sequences
- Specify language for syntax highlighting

### Tables
Use tables for structured reference information:

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `port` | number | 3000 | Server port |
| `debug` | boolean | false | Enable debug logging |

## Maintenance

- Review and update when code changes
- Add "Last updated" timestamps
- Mark deprecated features clearly
- Remove obsolete documentation

## Avoid

- **Jargon without explanation** — Define terms or link to glossary
- **Passive voice** — "The file is created" → "This command creates the file"
- **Ambiguous pronouns** — "It returns it" → "The function returns the result"
- **Assumptions about reader knowledge** — State prerequisites explicitly
- **Outdated examples** — Test examples with current version before publishing
- **Walls of text** — Break up with headings, lists, code blocks
- **Missing error cases** — Document what can go wrong and how to fix it
- **Incomplete examples** — Show imports, setup, and cleanup where relevant
- **"Simply", "just", "easy"** — What's easy for you may not be for the reader
- **Undocumented options** — Every parameter, option, and return value needs documentation
