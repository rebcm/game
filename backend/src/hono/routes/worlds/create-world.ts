import { Hono } from 'hono';
import { z } from 'zod';
import { validator } from 'hono/validator';

const createWorldSchema = z.object({
  name: z.string(),
});

const app = new Hono();

app.post(
  '/api/worlds',
  validator('json', (value, c) => {
    const result = createWorldSchema.safeParse(value);
    if (!result.success) {
      return c.json({ error: 'Dados inválidos' }, 400);
    }
    return result.data;
  }),
  async (c) => {
    const { name } = await c.req.json();
    const db = c.env.DB;

    const existingWorld = await db
      .prepare('SELECT id FROM worlds WHERE name = ?')
      .bind(name)
      .run();

    if (existingWorld.results.length > 0) {
      return c.json({ error: 'Mundo já existe' }, 400);
    }

    const { results } = await db
      .prepare('INSERT INTO worlds (name) VALUES (?) RETURNING id')
      .bind(name)
      .run();

    const worldId = results[0].id;

    // Initialize R2 bucket for chunks
    const r2 = c.env.R2;
    await r2.put(, JSON.stringify({}));

    return c.json({ id: worldId }, 201);
  }
);

export default app;
