---
name: qi-framework
description: QI Framework conventions and patterns. Use when working with QI-based applications and services.
user-invocable: false
---

# QI Framework Conventions

## Core Concepts

- QI (pronounced "chee") is a middleware framework for robotics and embedded systems
- Service-oriented architecture — components communicate via services
- Asynchronous by design — use futures and promises
- Cross-language support — C++, Python bindings
- Dynamic service discovery and registration

## Services

- Services are the primary abstraction for functionality
- Define services with clear interfaces and contracts
- Register services with the service directory
- Use service proxies for remote communication
- Services can be local or remote — location transparent

```cpp
// Service registration
qi::Session session;
session.connect("tcp://localhost:9559");
session.registerService("MyService", myServiceInstance);

// Service usage
auto proxy = session.service("MyService");
proxy.async<void>("myMethod", arg1, arg2);
```

## Signals and Properties

- Use `qi::Signal` for event notification
- Use `qi::Property` for observable values with change notifications
- Connect to signals with `.connect()` method
- Properties support binding and change callbacks
- Prefer signals/properties over polling

```cpp
qi::Signal<int> onValueChanged;
qi::Property<std::string> status;

// Connect to signal
onValueChanged.connect([](int value) {
    // Handle value change
});

// Property change notification
status.connect([](const std::string& newStatus) {
    // Handle status change
});
```

## Futures and Promises

- Use `qi::Future<T>` for asynchronous results
- Use `qi::Promise<T>` to create and fulfill futures
- Chain operations with `.andThen()`, `.then()`
- Use `.wait()` sparingly — prefer callbacks
- Handle errors with `.hasError()`, `.error()`

```cpp
qi::Future<int> result = someAsyncOperation();
result.andThen([](int value) {
    // Process result
}).andThen([](auto result) {
    // Chain another operation
});
```

## Object Model

- Use `qi::AnyObject` for type-erased service proxies
- Use `qi::Object<T>` for typed service wrappers
- Define object types with `QI_TYPE_STRUCT` or `QI_REGISTER_OBJECT`
- Use `qi::AnyValue` for dynamic typing when needed

## Sessions

- `qi::Session` manages connections to the service directory
- Connect before registering or using services
- Handle disconnection gracefully with reconnection logic
- Use session events for connection state monitoring

## Error Handling

- Check future errors with `.hasError()`
- Use exceptions for synchronous error handling
- Log errors with appropriate severity levels
- Provide meaningful error messages for debugging
- Use `qi::FutureException` for future-related errors

## Python Integration

- Use `qi.Session()` for session management
- Services are accessed as Python objects
- Signals connect with `.connect()` method
- Futures work with `.value()` and `.wait()`
- Use decorators for exposing Python services

```python
import qi

session = qi.Session()
session.connect("tcp://localhost:9559")

# Get service
tts = session.service("ALTextToSpeech")
tts.say("Hello")

# Async call
future = tts.say.async("Hello")
future.wait()
```

## Logging

- Use `qi::log` namespace for logging
- Set appropriate log levels: verbose, debug, info, warning, error
- Include context in log messages
- Use log categories for filtering
- Avoid logging in tight loops

## Configuration

- Use `qi::ApplicationSession` for standard app setup
- Configure endpoints via command line or config files
- Use environment variables for deployment-specific settings
- Handle configuration changes dynamically when possible

## Avoid

- **Blocking on futures in callbacks** — Leads to deadlocks
- **Ignoring future errors** — Always check and handle errors
- **Tight coupling to service implementations** — Use interfaces
- **Synchronous patterns for async operations** — Embrace futures
- **Global state** — Use services and dependency injection
- **Hardcoded endpoints** — Use service discovery
- **Ignoring disconnection events** — Handle gracefully
- **Large payloads in signals** — Use references or streaming
- **Polling for state changes** — Use properties and signals
- **Missing error context** — Include meaningful error messages
