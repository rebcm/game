import { Hono } from 'hono';

const app = new Hono();

app.get('/iluminacao', async (c) => {
  return c.json({ mensagem: 'Iluminação com luz solar e sombras suaves' });
});

export default app;
