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

// Timeout pattern
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
```javascript
async function withRetry(fn, { maxAttempts = 3, delayMs = 1000, backoff = 2 } = {}) {
  let lastError;
  for (let attempt = 1; attempt <= maxAttempts; attempt++) {
    try {
      return await fn();
    } catch (error) {
      lastError = error;
      if (attempt < maxAttempts) {
        const delay = delayMs * Math.pow(backoff, attempt - 1);
        await new Promise(resolve => setTimeout(resolve, delay));
      }
    }
  }
  throw lastError;
}

// Usage
const data = await withRetry(() => fetch('/api/flaky-endpoint'), {
  maxAttempts: 3,
  delayMs: 500,
});
```

## Throttle and Debounce
```javascript
// Debounce: wait until calls stop, then execute once
function debounce(fn, ms) {
  let timer;
  return (...args) => {
    clearTimeout(timer);
    timer = setTimeout(() => fn(...args), ms);
  };
}

// Throttle: execute at most once per interval
function throttle(fn, ms) {
  let lastCall = 0;
  return (...args) => {
    const now = Date.now();
    if (now - lastCall >= ms) {
      lastCall = now;
      fn(...args);
    }
  };
}
```

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
```javascript
// Process items with concurrency limit
async function processQueue(items, fn, concurrency = 5) {
  const results = [];
  let index = 0;

  async function worker() {
    while (index < items.length) {
      const i = index++;
      results[i] = await fn(items[i]);
    }
  }

  const workers = Array.from({ length: concurrency }, () => worker());
  await Promise.all(workers);
  return results;
}

// Usage: process 100 items, 5 at a time
await processQueue(urls, url => fetch(url), 5);
```
