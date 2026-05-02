import { Hono } from 'hono';
import { z } from 'zod';

const uploadChunkSchema = z.object({
  chunk: z.string(),
});

const app = new Hono();

app.post('/upload/chunk', async (c) => {
  const { chunk } = await c.req.json();
  const result = uploadChunkSchema.safeParse({ chunk });
  if (!result.success) {
    return c.json({ error: 'Invalid chunk data' }, 400);
  }
  // Implement chunk upload logic here
  return c.json({ message: 'Chunk uploaded successfully' });
});

app.post('/upload/large-file', async (c) => {
  const file = await c.req.json();
  // Implement large file upload logic here
  return c.json({ message: 'Large file uploaded successfully' });
});

export default app;
