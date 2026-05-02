import { Hono } from 'hono';

const app = new Hono();

app.get('/camera-3d/data', async (c) => {
  // TO DO: implement data fetching logic
  return c.json({ message: 'Camera 3D data' });
});

export default app;
