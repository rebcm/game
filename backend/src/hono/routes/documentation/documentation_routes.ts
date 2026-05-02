import { Hono } from 'hono';
import { z } from 'zod';

const documentationCriteriaSchema = z.object({
  characterLimit: z.number(),
  seoKeywords: z.array(z.string()),
  toneOfVoice: z.string(),
});

const app = new Hono();

app.get('/documentation/criteria', async (c) => {
  const criteria = await c.env.DB.prepare('SELECT * FROM documentation_criteria').all();
  return c.json(criteria.results[0]);
});

app.post('/documentation/criteria', async (c) => {
  const body = await c.req.json();
  const result = documentationCriteriaSchema.safeParse(body);

  if (!result.success) {
    return c.json({ error: 'Invalid request' }, 400);
  }

  await c.env.DB.prepare('INSERT INTO documentation_criteria (characterLimit, seoKeywords, toneOfVoice) VALUES (?, ?, ?)').run(
    result.data.characterLimit,
    JSON.stringify(result.data.seoKeywords),
    result.data.toneOfVoice,
  );

  return c.json({ message: 'Critérios atualizados com sucesso' });
});

export default app;
