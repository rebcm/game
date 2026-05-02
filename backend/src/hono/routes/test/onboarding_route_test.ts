import { test } from 'vitest';
import { Hono } from 'hono';
import { onboardingRoute } from './onboarding';

test('Onboarding route test', async () => {
  const c = new Hono();
  const res = await onboardingRoute(c);
  expect(res.status).toBe(200);
});
