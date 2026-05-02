import { Hono } from 'hono';
import { z } from 'zod';

const i18nRoute = new Hono();

const descriptionSchema = z.object({
  description: z.string().min(10, 'Descrição deve ter pelo menos 10 caracteres'),
});

i18nRoute.post('/validate-description', async (c) => {
  const { description } = await c.req.json();
  const result = descriptionSchema.safeParse({ description });
  if (!result.success) {
    return c.json({ error: result.error.issues[0].message }, 400);
  }
  return c.json({ message: 'Descrição válida' });
});

export default i18nRoute;
