import { Hono } from 'hono';
import { Context } from 'hono';

const app = new Hono();

app.get('/chunks/:x/:y/:z', async (c: Context) => {
  const { x, y, z } = c.req.param();
  const chunkData = await c.env.DB.prepare('SELECT * FROM chunks WHERE x = ? AND y = ? AND z = ?').all(x, y, z);
  return c.json(chunkData.results);
});

export default app;
