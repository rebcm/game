import { Hono } from 'hono';
import authenticateAndValidate from './authenticate_and_validate';

const app = new Hono();

app.post('/api/worlds', authenticateAndValidate, async (c) => {
  const worldData = await c.req.json();
  // Lógica para criar um novo mundo
  const newWorld = await c.env.DB.prepare('INSERT INTO worlds (user_id, data) VALUES (?, ?) RETURNING *').bind(c.get('userId'), JSON.stringify(worldData)).run();
  return c.json(newWorld.results[0], 201);
});

export default app;
