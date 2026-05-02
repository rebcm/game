import { Hono } from 'hono';
import { Context } from 'hono';
const noiseController = new Hono();
noiseController.get('/noise', async (c: Context) => {
  // implement noise calculation logic here
  return c.json({ noise: 0.0 });
});
export default noiseController;
