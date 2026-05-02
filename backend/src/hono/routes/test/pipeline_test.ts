import { Hono } from 'hono';
import { test } from 'vitest';

const app = new Hono();

app.get('/test/pipeline', async (c) => {
  return c.text('Pipeline funcionando corretamente');
});

test('GET /test/pipeline', async () => {
  const res = await app.request('/test/pipeline');
  expect(res.status).toBe(200);
  expect(await res.text()).toBe('Pipeline funcionando corretamente');
});
