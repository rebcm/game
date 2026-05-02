import { Hono } from 'hono';
import { Context } from 'hono';
const jogoRoute = new Hono();
jogoRoute.get('/', async (c: Context) => {
  return c.json({ message: 'Jogo PassDriver' });
});
export default jogoRoute;
