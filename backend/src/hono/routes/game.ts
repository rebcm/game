import { Hono } from 'hono';
import { Context } from 'hono';

const game = new Hono();

game.get('/status', async (c: Context) => {
  return c.json({ status: 'ok' });
});

export default game;
