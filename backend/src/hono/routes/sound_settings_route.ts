import { Hono } from 'hono';
import { Context } from 'hono/context';

const app = new Hono();

app.get('/sound-settings', async (c: Context) => {
  // TO DO: implement retrieving sound settings from storage
  return c.json({ volume: 1.0, isMuted: false });
});

app.post('/sound-settings', async (c: Context) => {
  const { volume, isMuted } = await c.req.json();
  // TO DO: implement saving sound settings to storage
  return c.json({ message: 'Configurações de som salvas com sucesso' });
});

export default app;
