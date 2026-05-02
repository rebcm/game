import { Hono } from 'hono';

const app = new Hono();

app.get('/api/endpoint', (c) => {
  return c.json({ message: 'Hello World' }, 200);
});

app.get('/api/invalid-endpoint', (c) => {
  return c.json({ error: 'Not Found' }, 404);
});

export default app;
