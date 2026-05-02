import { Hono } from 'hono';
import { z } from 'zod';

const retentionPolicySchema = z.object({
  expirationTime: z.number(),
});

const app = new Hono();

app.get('/artifacts/retention-policy', async (c) => {
  const db = c.env.DB;
  const result = await db.prepare('SELECT expiration_time FROM retention_policy WHERE id = 1').run();
  if (result.success) {
    return c.json({ expirationTime: result.results[0].expiration_time });
  } else {
    return c.json({ error: 'Falha ao carregar política de retenção' }, 500);
  }
});

app.put('/artifacts/retention-policy', async (c) => {
  const db = c.env.DB;
  const { expirationTime } = await c.req.json();
  const parsed = retentionPolicySchema.safeParse({ expirationTime });
  if (!parsed.success) {
    return c.json({ error: 'Dados inválidos' }, 400);
  }
  const result = await db.prepare('UPDATE retention_policy SET expiration_time = ? WHERE id = 1').bind(parsed.data.expirationTime).run();
  if (result.success) {
    return c.json({ message: 'Política de retenção atualizada' });
  } else {
    return c.json({ error: 'Falha ao atualizar política de retenção' }, 500);
  }
});

export default app;
