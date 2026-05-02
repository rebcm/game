import { Hono } from 'hono';
import { db } from '../../db';
const app = new Hono();
app.get('/blocos', async c => {
  const blocos = await c.env.DB.prepare('SELECT * FROM blocos').all();
  return c.json(blocos.results);
});
export default app;
