# Spring Boot Reference

## Controller Pattern
```java
@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
public class UserController {
  private final UserService userService;

  @GetMapping("/{id}")
  public UserResponse getUser(@PathVariable UUID id) {
    return userService.findById(id);
  }

  @PostMapping
  @ResponseStatus(HttpStatus.CREATED)
  public UserResponse createUser(@Valid @RequestBody CreateUserRequest request) {
    return userService.create(request);
  }
}
```

## Service Pattern
```java
@Service
@RequiredArgsConstructor
public class UserService {
  private final UserRepository userRepository;
  private final EventPublisher eventPublisher;

  @Transactional
  public UserResponse create(CreateUserRequest request) {
    if (userRepository.findByEmail(request.email()).isPresent()) {
      throw new DuplicateEmailException(request.email());
    }
    var user = User.from(request);
    userRepository.save(user);
    eventPublisher.publish(new UserCreatedEvent(user.getId()));
    return UserResponse.from(user);
  }
}
```

## Exception Handler
```java
@RestControllerAdvice
public class GlobalExceptionHandler {
  @ExceptionHandler(EntityNotFoundException.class)
  @ResponseStatus(HttpStatus.NOT_FOUND)
  public ErrorResponse handleNotFound(EntityNotFoundException ex) {
    return new ErrorResponse("NOT_FOUND", ex.getMessage());
  }

  @ExceptionHandler(MethodArgumentNotValidException.class)
  @ResponseStatus(HttpStatus.BAD_REQUEST)
  public ErrorResponse handleValidation(MethodArgumentNotValidException ex) {
    var errors = ex.getBindingResult().getFieldErrors().stream()
        .map(e -> e.getField() + ": " + e.getDefaultMessage())
        .toList();
    return new ErrorResponse("VALIDATION_ERROR", errors);
  }
}
```

## Configuration
```yaml
# application.yml
spring:
  datasource:
    url: ${DATABASE_URL}
  jpa:
    open-in-view: false
    hibernate:
      ddl-auto: validate
  jackson:
    default-property-inclusion: non_null
    serialization:
      write-dates-as-timestamps: false

server:
  error:
    include-message: never
    include-stacktrace: never
```
