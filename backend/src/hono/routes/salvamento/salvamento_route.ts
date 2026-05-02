import { Hono } from 'hono';
const app = new Hono();
app.get('/salvamento', async (c) => { return c.json({}); });
export default app;
