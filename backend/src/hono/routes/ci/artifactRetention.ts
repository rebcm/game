import { Hono } from 'hono';
import { z } from 'zod';
import { zValidator } from '@hono/zod-validator';

const retentionPolicySchema = z.object({
  expirationDays: z.number().int().positive(),
});

const app = new Hono();

app.post(
  '/ci/artifact-retention',
  zValidator('json', retentionPolicySchema),
  async (c) => {
    const { expirationDays } = c.req.valid('json');
    await c.env.KV.put('artifactRetentionPolicy', JSON.stringify({ expirationDays }));
    return c.json({ message: 'Política de retenção atualizada com sucesso' }, 200);
  }
);

app.get('/ci/artifact-retention', async (c) => {
  const retentionPolicy = await c.env.KV.get('artifactRetentionPolicy');
  if (!retentionPolicy) {
    return c.json({ message: 'Política de retenção não configurada' }, 404);
  }
  return c.json(JSON.parse(retentionPolicy), 200);
});

export default app;
