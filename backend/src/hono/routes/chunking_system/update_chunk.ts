import { Hono } from 'hono';
import { Context } from 'hono/context';

const app = new Hono();

app.post('/update-chunk', async (c: Context) => {
  const { chunk } = await c.req.json();
  const db = c.env.DB;

  await db.prepare('UPDATE chunks SET data = ? WHERE id = ?')
    .bind(chunk.data, chunk.id)
    .run();

  return c.json({ message: 'Chunk atualizado com sucesso' });
});

export default app;
