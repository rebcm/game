import { describe, it, expect } from 'vitest';\n
import { retryPolicyRoute } from '../../src/hono/routes/retry_policy/retry_policy_route';\n
describe('Retry Policy Route', () => {
  it('returns retry policy for network error', async () => {
    const res = await retryPolicyRoute.request('/retry-policy?errorType=network_error');
    expect(res.status).toBe(200);
    expect(await res.json()).toEqual({ policy: 'retry', maxAttempts: 3 });
  });

  it('returns retry policy for server error', async () => {
    const res = await retryPolicyRoute.request('/retry-policy?errorType=server_error');
    expect(res.status).toBe(200);
    expect(await res.json()).toEqual({ policy: 'failFast', maxAttempts: 1 });
  });
});
