import { Hono } from 'hono';
import { z } from 'zod';

const apiTestRoute = new Hono();

apiTestRoute.get('/api/test', async (c) => {
  return c.json({ data: 'API test success' }, 200);
});

apiTestRoute.get('/api/test-error', async (c) => {
  return c.json({ error: 'API test error' }, 500);
});

export default apiTestRoute;
