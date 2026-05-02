import { Hono } from 'hono';
import { Context } from 'hono';

const app = new Hono();

app.get('/build_config', async (c: Context) => {
  const isTagBuild = c.req.query('isTagBuild') === 'true';
  const expiration = isTagBuild ? 365 * 24 * 60 * 60 : 2 * 60 * 60; // in seconds
  return c.json({ expiration });
});

export default app;
