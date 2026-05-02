import { Hono } from 'hono';
import { Context } from 'hono';
const app = new Hono();
app.get('/jogo/:id', async (c: Context) => {
  const id = c.req.param('id');
  const db = c.env.DB;
  const result = await db.prepare('SELECT * FROM jogos WHERE id = ?').bind(id).run();
  if (result.success) {
    return c.json(result.results[0]);
  } else {
    return c.json({ error: 'Jogo não encontrado' }, 404);
  }
});
export default app;
