import { Hono } from 'hono';
import authenticateAndValidate from './authenticate_and_validate';

const app = new Hono();

app.post('/api/worlds', authenticateAndValidate, async (c: any) => {
  const worldData = await c.req.json();
  // Logic to create a new world
  await c.env.DB.prepare('INSERT INTO worlds (user_id, data) VALUES (?, ?)').bind(c.req.header('user-id'), JSON.stringify(worldData)).run();
  return c.json({ message: 'Mundo criado com sucesso' }, 201);
});

export default app;
