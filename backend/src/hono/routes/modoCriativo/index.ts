import { Hono } from 'hono';
import { Context } from 'hono';
const app = new Hono();
app.get('/modo-criativo', async (c: Context) => {
  return c.json({ voarHabilitado: true });
});
export default app;
