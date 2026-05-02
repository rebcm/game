import { Hono } from 'hono';
import { z } from 'zod';

const rideStatusSchema = z.enum(['walking', 'driving', 'stopped']);

const app = new Hono();

app.post('/ride/status', async (c) => {
  const { status } = await c.req.json();
  const result = rideStatusSchema.safeParse(status);

  if (!result.success) {
    return c.json({ error: 'Invalid ride status' }, 400);
  }

  // Update ride status in DB
  await c.env.DB.prepare('UPDATE rides SET status = ? WHERE id = ?').run(result.data, 'ride-id');

  return c.json({ message: 'Ride status updated successfully' });
});

export default app;
