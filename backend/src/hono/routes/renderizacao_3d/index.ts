import { Hono } from 'hono';
import { Context } from 'hono';

const app = new Hono();

app.get('/renderizacao-3d', async (c: Context) => {
  return c.json({ message: 'Renderização 3D em desenvolvimento' });
});

export default app;
