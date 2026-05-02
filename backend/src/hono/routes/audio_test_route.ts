import { Hono } from 'hono';
import { Context } from 'hono';

const app = new Hono();

app.get('/audio-test', async (c: Context) => {
  return c.json({ message: 'Áudio test route' });
});

export default app;
