import { Hono } from 'hono';
import { z } from 'zod';
import { env } from '../../env';

const app = new Hono();

const chunkSchema = z.object({
  id: z.string(),
  version: z.number(),
  data: z.string(),
});

app.post('/r2/chunks', async (c) => {
  const { id, version, data } = chunkSchema.parse(await c.req.json());
  const chunkName = ${id}-${version}.chunk;
  await env.R2.put(chunkName, data);
  return c.json({ message: 'Chunk criado com sucesso' }, 201);
});

app.get('/r2/chunks/:id', async (c) => {
  const id = c.req.param('id');
  const version = await env.KV.get(${id}-version);
  if (!version) return c.json({ error: 'Chunk não encontrado' }, 404);
  const chunkName = ${id}-${version}.chunk;
  const chunk = await env.R2.get(chunkName);
  if (!chunk) return c.json({ error: 'Chunk não encontrado' }, 404);
  return c.text(await chunk.text());
});

export default app;
