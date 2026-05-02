import { Hono } from 'hono';
import { Context } from 'hono';

const app = new Hono();

app.get('/self_healing_test', async (c: Context) => {
  return c.text('Self Healing Test');
});

export default app;
