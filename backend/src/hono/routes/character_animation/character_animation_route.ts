import { Hono } from 'hono';
import { z } from 'zod';

const characterAnimationSchema = z.object({
  tolerance: z.number(),
});

const app = new Hono();

app.post('/character-animation/tolerance', async (c) => {
  const { tolerance } = await c.req.json();
  const result = characterAnimationSchema.safeParse({ tolerance });
  if (!result.success) {
    return c.json({ error: 'Invalid tolerance value' }, 400);
  }
  // Save tolerance to KV or D1 SQLite
  return c.json({ message: 'Tolerance updated successfully' });
});

export default app;
