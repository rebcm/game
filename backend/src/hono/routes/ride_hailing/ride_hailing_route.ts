import { Hono } from 'hono';
import { timeout } from 'hono/timeout';

const app = new Hono();

app.get('/ride_hailing/data', timeout(1000), async (c) => {
  try {
    // Simulate a slow response
    await new Promise((resolve) => setTimeout(resolve, 2000));
    return c.json({ message: 'Ride hailing data' });
  } catch (error) {
    if (error instanceof TimeoutError) {
      return c.json({ error: 'Timeout ao solicitar dados de ride hailing' }, 408);
    }
    throw error;
  }
});

export default app;
