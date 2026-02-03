---
name: java
description: Java language conventions, Spring patterns, and enterprise architecture. Use when working with Java applications, Spring Boot services, or JVM-based projects.
user-invocable: false
---

# Java Conventions

## Language

- Use Java 17+ features: records, sealed classes, pattern matching, text blocks
- Prefer records for immutable data carriers
- Use sealed interfaces for closed type hierarchies
- Prefer `var` for local variables when the type is obvious from context
- Use `Optional` for return types that may be absent -- never for parameters or fields
- Prefer streams for collection transformations, loops for side effects

## Architecture

- Follow layered architecture: Controller → Service → Repository
- Keep controllers thin -- validation and HTTP concerns only
- Business logic belongs in services
- Use constructor injection (implicit with single constructor)
- Keep methods short and single-purpose

## Error Handling

- Define domain-specific exceptions extending `RuntimeException`
- Use `@RestControllerAdvice` for centralized exception handling
- Return appropriate HTTP status codes
- Never expose stack traces in API responses
- Log errors with context (user ID, request ID, operation)

## Naming

- Classes: `PascalCase`
- Methods/variables: `camelCase`
- Constants: `UPPER_SNAKE_CASE`
- Packages: `lowercase.dot.separated`
- Test classes: `ClassNameTest`

## Avoid

- **Catching `Exception` generically** — Catch specific exceptions; generic catch hides bugs
- **Returning `null`** — Use `Optional<T>` for absent values; null causes NPEs
- **Field injection (`@Autowired` on fields)** — Use constructor injection for testability and immutability
- **Mutable static state** — Causes threading issues and test pollution
- **Exposing internal collections** — Return defensive copies or unmodifiable views
- **`new` for Spring beans** — Let Spring manage dependencies; use `@Component` or `@Bean`
- **Business logic in controllers** — Controllers handle HTTP; delegate to services
- **Checked exceptions in lambdas** — Wrap in unchecked or use utility methods
- **`Optional` as parameter or field** — Use only for return types
- **Suppressing `SonarQube`/`SpotBugs` warnings without justification** — Fix the issue instead
