import { Hono } from 'hono';
import { Context } from 'hono/context';

const app = new Hono();

app.get('/chunks-around-location', async (c: Context) => {
  const { lat, lng, radius } = await c.req.json();
  const db = c.env.DB;

  const chunks = await db.prepare('SELECT * FROM chunks WHERE ST_DistanceSphere(geom, ST_GeomFromText(?, 4326)) <= ?')
    .bind(, radius)
    .all();

  return c.json(chunks.results);
});

export default app;
