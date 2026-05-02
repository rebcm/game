import { Hono } from 'hono';

const app = new Hono();

app.get('/api/worlds', async (c) => {
  const db = c.env.DB;
  const results = await db.prepare('SELECT * FROM mundos WHERE user_id = ?').all(c.get('userId'));
  return c.json(results.results);
});

export default app;
