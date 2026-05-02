import { test } from 'vitest';
import { app } from '../app';

test('GET /ride-status should return ride status', async () => {
  const res = await app.request('/ride-status');
  expect(res.status).toBe(200);
});

test('POST /cancel-ride should cancel ride', async () => {
  const res = await app.request('/cancel-ride', {
    method: 'POST',
  });
  expect(res.status).toBe(200);
});

