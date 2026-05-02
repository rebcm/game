import { Hono } from 'hono';
import { z } from 'zod';

const ambienteSchema = z.object({
  ambiente: z.string(),
});

const app = new Hono();

app.get('/configuracoes-ambiente', async (c) => {
  const ambiente = c.env.KV.get('ambiente');
  return c.json({ ambiente });
});

app.post('/configuracoes-ambiente', async (c) => {
  const { ambiente } = await c.req.json();
  const result = ambienteSchema.safeParse({ ambiente });
  if (!result.success) {
    return c.json({ error: 'Invalid ambiente' }, 400);
  }
  await c.env.KV.put('ambiente', ambiente);
  return c.json({ ambiente });
});

export default app;
