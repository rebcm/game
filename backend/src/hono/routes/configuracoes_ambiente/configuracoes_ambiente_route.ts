import { Hono } from 'hono';
import { Context } from 'hono';

const app = new Hono();

app.get('/configuracoes-ambiente', async (c: Context) => {
  const ambiente = c.env.KV.get('ambiente');
  return c.json({ ambiente });
});

export default app;
