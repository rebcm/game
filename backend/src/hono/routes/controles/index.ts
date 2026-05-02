import { Hono } from 'hono';
import { Context } from 'hono';
const app = new Hono();
app.get('/edge-cases', async (c: Context) => {
  const edgeCases = await c.env.DB.prepare('SELECT * FROM edge_cases').all();
  return c.json(edgeCases.results);
}); 
export default app;
