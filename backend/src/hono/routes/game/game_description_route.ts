import { Hono } from 'hono';
import { cors } from 'hono/cors';
import { sqlite } from '@hono/db';

const app = new Hono();
app.use('*', cors());

app.get('/game-description', async (c) => {
  const db = sqlite(c.env.DB);
  const gameDescription = await db.get('game_description');
  return c.json(gameDescription);
});

export default app;
