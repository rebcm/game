import { Hono } from 'hono';
import { db } from '../../../database';

const app = new Hono();

app.get('/api/worlds', async (c) => {
  const userId = c.get('userId');
  const worlds = await db(c.env.DB).prepare('SELECT * FROM worlds WHERE user_id = ?').all(userId);
  return c.json(worlds.results);
});

export default app;
