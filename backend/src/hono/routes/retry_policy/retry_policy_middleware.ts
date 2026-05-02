import { Hono } from 'hono';
import { RetryPolicy } from './retry_policy_enum';

const retryPolicy = async (c: Context, next: Next) => {
  const policy = c.req.header('X-Retry-Policy') as RetryPolicy;
  const maxRetries = parseInt(c.req.header('X-Max-Retries') || '3');

  if (policy === RetryPolicy.retry) {
    // implement retry logic
  } else {
    // implement fail-fast logic
  }

  return next();
};

export default retryPolicy;
