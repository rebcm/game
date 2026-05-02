import { Hono } from 'hono';
import { Context } from 'hono';

const app = new Hono();

app.get('/iluminacao', async (c: Context) => {
  return c.json({ message: 'Iluminação com luz solar e sombras suaves' });
});

export default app;
