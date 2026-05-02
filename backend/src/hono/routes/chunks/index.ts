import { Hono } from 'hono';
import { z } from 'zod';

const app = new Hono();

const chunkSchema = z.object({
  x: z.number(),
  y: z.number(),
  zoom: z.number(),
});

app.get('/chunks', async (c) => {
  const { x, y, zoom } = await c.req.query();
  const result = chunkSchema.safeParse({ x: Number(x), y: Number(y), zoom: Number(zoom) });
  if (!result.success) {
    return c.json({ error: 'Parâmetros inválidos' }, 400);
  }
  // implement logic to retrieve chunk data from c.env.DB or c.env.KV
  return c.json({ /* chunk data */ });
});

export default app;
