import { Hono } from 'hono';

const app = new Hono();

app.get('/chunk', async (c) => {
  // implement chunk loading logic here
  return c.json({});
});

app.post('/chunk', async (c) => {
  // implement chunk unloading logic here
  return c.json({});
});

export const chunkingRoute = app;
