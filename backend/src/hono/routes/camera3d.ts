import { Hono } from 'hono';

const app = new Hono();

app.get('/camera3d/data', async (c) => {
  // TO DO: implement API endpoint logic
  return c.json({ message: 'Camera 3D data' });
});

export default app;
