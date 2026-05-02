import { Hono } from 'hono';
import { Context } from 'hono';

const app = new Hono();

app.get('/localization', async (c: Context) => {
  const locale = c.req.header('Accept-Language');
  return c.json({ locale });
});

export default app;
