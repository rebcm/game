import { Hono } from 'hono';
import { z } from 'zod';

const configuracoesAmbienteSchema = z.object({
  ambiente: z.string(),
});

const app = new Hono();

app.get('/configuracoes-ambiente', async (c) => {
  const ambiente = await c.env.KV.get('ambiente');
  return c.json({ ambiente });
});

app.post('/configuracoes-ambiente', async (c) => {
  const { ambiente } = await c.req.json();
  const result = configuracoesAmbienteSchema.safeParse({ ambiente });
  if (!result.success) {
    return c.json({ error: 'Invalid request' }, 400);
  }
  await c.env.KV.put('ambiente', ambiente);
  return c.json({ message: 'Ambiente atualizado com sucesso' });
});

export default app;
