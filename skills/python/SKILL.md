---
name: python
description: Python language conventions, patterns, and best practices. Use when working with Python code or data processing.
user-invocable: false
---

# Python Conventions

## Language

- Use Python 3.10+ features: pattern matching, structural typing, walrus operator
- Prefer f-strings over `.format()` or `%` formatting
- Use type hints everywhere — `def func(name: str) -> int:`
- Prefer `pathlib.Path` over `os.path` for file operations
- Use context managers (`with`) for resource management
- Prefer list/dict comprehensions over map/filter when readable

## Type Hints

- Use builtin generics: `list[str]`, `dict[str, int]`, `tuple[int, ...]` (Python 3.10+)
- Use `X | Y` union syntax instead of `typing.Union` (Python 3.10+)
- Prefer `X | None` over `Optional[X]` (Python 3.10+)
- Use `TypedDict` for structured dictionaries
- Use `Protocol` for structural subtyping (duck typing with types)
- Use `Literal` for exact value types
- Use `Callable` from `collections.abc`, not `typing`

## Error Handling

- Use specific exceptions, not bare `except:`
- Define custom exception classes for domain errors
- Use `raise ... from e` to chain exceptions with context
- Log exceptions with traceback using `logging.exception()`
- Avoid silencing exceptions without explicit reason

## Async (asyncio)

- Use `async`/`await` for I/O-bound operations
- Use `asyncio.gather()` for concurrent tasks
- Use `asyncio.TaskGroup` (Python 3.11+) for structured concurrency
- Avoid blocking calls in async functions — use `run_in_executor`
- Prefer `async for` and `async with` where applicable

## Project Structure

- Use `pyproject.toml` for project configuration
- Use virtual environments (`venv`, `poetry`, or `uv`)
- Organize with `src/` layout for packages
- Keep `__init__.py` minimal — avoid circular imports
- Use `__all__` to define public API

## Naming

- Classes: `PascalCase`
- Functions/variables: `snake_case`
- Constants: `SCREAMING_SNAKE_CASE`
- Private: `_single_leading_underscore`
- "Dunder" methods: `__double_underscore__`

## Avoid

- **Mutable default arguments** — Use `None` and set inside function
- **Global state** — Pass dependencies explicitly or use dependency injection
- **Bare `except:`** — Always catch specific exceptions
- **`import *`** — Import specific names or use qualified imports
- **Magic numbers** — Define named constants
- **Deep nesting** — Extract to functions, use early returns
- **String concatenation in loops** — Use `''.join()` or f-strings
- **`type()` for type checking** — Use `isinstance()` instead
- **Ignoring return values** — Handle or explicitly discard with `_`
- **Print debugging** — Use `logging` module or debugger
