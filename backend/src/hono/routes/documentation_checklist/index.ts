import { Hono } from 'hono';
import { z } from 'zod';

const documentationChecklistSchema = z.object({
  title: z.string(),
  maxCharacters: z.number(),
  hasCTA: z.boolean(),
  link: z.string(),
});

const app = new Hono();

app.post('/documentation-checklist', async (c) => {
  const { title, maxCharacters, hasCTA, link } = await c.req.json();
  const result = documentationChecklistSchema.safeParse({ title, maxCharacters, hasCTA, link });

  if (!result.success) {
    return c.json({ error: 'Dados inválidos' }, 400);
  }

  const db = c.env.DB;
  await db.prepare('INSERT INTO documentation_checklist (title, max_characters, has_cta, link) VALUES (?, ?, ?, ?)').run(title, maxCharacters, hasCTA, link);

  return c.json({ message: 'Checklist criado com sucesso' });
});

export default app;
