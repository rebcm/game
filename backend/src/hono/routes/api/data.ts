import { Hono } from 'hono';
import { handle } from 'hono/cloudflare-workers';

const api = new Hono();

api.get('/data', async (c) => {
  if (Math.random() < 0.5) {
    return c.text('Erro interno', 500);
  }
  return c.json({ message: 'OK' });
});

export default api;
