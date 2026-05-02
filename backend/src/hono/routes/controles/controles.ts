import { Hono } from 'hono';
import { Context } from 'hono';

const app = new Hono();

app.get('/controles', async (c: Context) => {
  return c.json({ mensagem: 'Controles Web/Desktop' });
});

export default app;
