import { Hono } from 'hono';
import { z } from 'zod';

const gravityRoute = new Hono();

gravityRoute.get('/gravidade', async (c) => {
  const db = c.env.DB;
  const results = await db.prepare('SELECT * FROM gravity_zones').all();
  return c.json(results.results);
});

gravityRoute.post('/gravidade', async (c) => {
  const { latitude, longitude, altitude, gravity } = await c.req.json();
  const db = c.env.DB;
  await db.prepare('INSERT INTO gravity_zones (latitude, longitude, altitude, gravity) VALUES (?, ?, ?, ?)').run(latitude, longitude, altitude, JSON.stringify(gravity));
  return c.json({ message: 'Zona de gravidade criada com sucesso' });
});

export default gravityRoute;
