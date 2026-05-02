import { Hono } from 'hono';

const app = new Hono();

app.get('/healthcheck', (c) => {
  return c.text('OK', 200);
});

export default app;
