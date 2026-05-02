import { Hono } from 'hono';
import { z } from 'zod';

const analysisSchema = z.object({
  text: z.string(),
});

const docsAnalysisRoute = new Hono()
  .post('/analyze', async (c) => {
    const { text } = await c.req.json();
    const result = analysisSchema.safeParse({ text });
    if (!result.success) {
      return c.json({ error: 'Invalid request' }, 400);
    }
    // Implement comprehensibility analysis logic here
    return c.json({ message: 'Análise realizada com sucesso!' });
  });

export default docsAnalysisRoute;
