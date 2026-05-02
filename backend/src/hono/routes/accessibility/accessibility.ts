import { Hono } from 'hono';
const accessibilityRoute = new Hono();
accessibilityRoute.get('/accessibility/config', async (c) => {
  const config = await c.env.KV.get('accessibility_config');
  return c.json(config);
});
export default accessibilityRoute;
