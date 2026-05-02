import { Hono } from 'hono';
import { Context } from 'hono';

const app = new Hono();

app.get('/version', async (c: Context) => {
  const version = c.env.KV.get('VERSION');

  return c.json({ version });
});

export default app;
