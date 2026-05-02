import { Hono } from 'hono';
import { Context } from 'hono';
const app = new Hono();
app.get('/accessibility/settings', async (c: Context) => {
  const settings = await c.env.KV.get('accessibility_settings');
  return c.json(settings);
});
export default app;
