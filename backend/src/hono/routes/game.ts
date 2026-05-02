import { Hono } from 'hono';
import { Context } from 'hono/context';

const app = new Hono();

app.get('/game', async (c: Context) => {
  return c.json({ message: 'Game route' });
});

export default app;
