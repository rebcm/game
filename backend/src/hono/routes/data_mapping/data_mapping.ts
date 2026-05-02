import { Hono } from 'hono';
import { Context } from 'hono/context';

const app = new Hono();

app.get('/data-mapping', async (c: Context) => {
  // TO BE IMPLEMENTED: fetch data types and their classification from D1 SQLite or KV
  return c.json({ message: 'Data mapping endpoint' });
});

export default app;
