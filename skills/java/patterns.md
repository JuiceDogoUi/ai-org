# Java Patterns Reference

## Record with Validation
```java
public record CreateUserRequest(
    @NotBlank String name,
    @Email String email,
    @Min(0) int age
) {
  public CreateUserRequest {
    name = name.strip();
    email = email.toLowerCase();
  }
}
```

## Sealed Interface
```java
public sealed interface PaymentResult {
  record Success(String transactionId, BigDecimal amount) implements PaymentResult {}
  record Declined(String reason) implements PaymentResult {}
  record Error(Exception cause) implements PaymentResult {}
}
```

## Repository Pattern
```java
public interface UserRepository extends JpaRepository<User, UUID> {
  Optional<User> findByEmail(String email);

  @Query("SELECT u FROM User u WHERE u.status = :status AND u.createdAt > :since")
  List<User> findActiveUsersSince(@Param("status") Status status, @Param("since") Instant since);
}
```

## Builder with Validation
```java
public record QueryOptions(int page, int size, String sortBy, Direction direction) {
  public static Builder builder() { return new Builder(); }

  public static class Builder {
    private int page = 0;
    private int size = 20;
    private String sortBy = "createdAt";
    private Direction direction = Direction.DESC;

    public Builder page(int page) { this.page = page; return this; }
    public Builder size(int size) { this.size = Math.min(size, 100); return this; }
    public QueryOptions build() { return new QueryOptions(page, size, sortBy, direction); }
  }
}
```
