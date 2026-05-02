import { Hono } from 'hono';
import { Context } from 'hono';
const passdriverRoute = new Hono();
passdriverRoute.get('/passdriver/test', async (c: Context) => {
  return c.text('Passdriver route working');
});
export default passdriverRoute;
