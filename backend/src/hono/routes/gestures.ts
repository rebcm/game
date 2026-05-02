import { Hono } from 'hono';
import { Context } from 'hono';
const gestures = new Hono();
gestures.get('/gestures', async (c: Context) => {
  return c.json({ message: 'Gestos detectados' });
});
export default gestures;
