import { Hono } from 'hono';

const app = new Hono();

app.get('/example', async (c) => {
  if (Math.random() < 0.5) {
    return c.text('Internal Server Error', 503);
  } else {
    return c.json({ message: 'OK' });
  }
});

export default app;
