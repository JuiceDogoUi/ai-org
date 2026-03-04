# Async JavaScript Patterns

## async/await

### Basic Error Handling
```javascript
async function fetchUser(id) {
  try {
    const response = await fetch(`/api/users/${id}`);
    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    }
    return await response.json();
  } catch (error) {
    if (error.name === 'AbortError') {
      console.log('Request was cancelled');
      return null;
    }
    throw error; // re-throw unexpected errors
  }
}
```

### Concurrent Operations
```javascript
// GOOD: Independent operations run concurrently
const [users, products, orders] = await Promise.all([
  fetchUsers(),
  fetchProducts(),
  fetchOrders(),
]);

// BAD: Sequential when they could be concurrent
const users = await fetchUsers();
const products = await fetchProducts();
const orders = await fetchOrders();
```

### Promise.allSettled for Partial Failures
```javascript
const results = await Promise.allSettled([
  fetchFromPrimary(),
  fetchFromFallback(),
  fetchFromCache(),
]);

const successful = results
  .filter(r => r.status === 'fulfilled')
  .map(r => r.value);

const failed = results
  .filter(r => r.status === 'rejected')
  .map(r => r.reason);
```

## Cancellation

### AbortController
```javascript
const controller = new AbortController();

// Pass signal to fetch
const response = await fetch('/api/data', {
  signal: controller.signal,
});

// Cancel from elsewhere
controller.abort();
```

### Timeout with AbortController
```javascript
const controller = new AbortController();
const timeoutId = setTimeout(() => controller.abort(), 5000);

try {
  const response = await fetch('/api/data', { signal: controller.signal });
  clearTimeout(timeoutId);
  return await response.json();
} catch (error) {
  clearTimeout(timeoutId);
  if (error.name === 'AbortError') {
    throw new Error('Request timed out');
  }
  throw error;
}
```

### AbortSignal.timeout (modern)
```javascript
// Built-in timeout signal
const response = await fetch('/api/data', {
  signal: AbortSignal.timeout(5000),
});
```

## Retry Pattern

Wrap async calls in a retry loop with exponential backoff. Accept `maxAttempts`, `delayMs`, and `backoff` multiplier as options. Multiply delay by the backoff factor on each attempt. Re-throw the last error after all attempts are exhausted.

## Throttle and Debounce

- **Debounce**: Return a wrapper that clears and resets a `setTimeout` on each call — executes once after calls stop.
- **Throttle**: Return a wrapper that tracks the last call time and only executes if the interval has elapsed.

For production use, check if the project already has a utility library (lodash, etc.) before implementing from scratch.

## Async Iteration
```javascript
// Async generator for paginated APIs
async function* fetchAllPages(baseUrl) {
  let page = 1;
  let hasMore = true;

  while (hasMore) {
    const response = await fetch(`${baseUrl}?page=${page}`);
    const data = await response.json();
    yield* data.items;
    hasMore = data.hasNextPage;
    page++;
  }
}

// Consume with for-await-of
for await (const item of fetchAllPages('/api/products')) {
  processItem(item);
}
```

## Queue Pattern

Process items with a concurrency limit: spawn N worker functions that pull from a shared index, each awaiting `fn(item)` in a loop. Use `Promise.all` on the workers. This bounds concurrent operations (e.g., 5 parallel fetches for 100 URLs). For production use, consider existing libraries like `p-limit` or `p-queue`.
