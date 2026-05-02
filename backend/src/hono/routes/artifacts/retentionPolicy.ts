import { Hono } from 'hono';
import { z } from 'zod';
import { env } from '../../env';

const retentionPolicySchema = z.object({
  expirationTime: z.number(),
});

const app = new Hono();

app.post('/artifacts/retention-policy', async (c) => {
  const { expirationTime } = retentionPolicySchema.parse(await c.req.json());
  await c.env.DB.prepare('UPDATE retention_policy SET expiration_time = ?').run(expirationTime);
  return c.json({ message: 'Política de retenção atualizada com sucesso' });
});

app.get('/artifacts/retention-policy', async (c) => {
  const { results } = await c.env.DB.prepare('SELECT expiration_time FROM retention_policy').all();
  return c.json({ expirationTime: results[0].expiration_time });
});

export default app;
