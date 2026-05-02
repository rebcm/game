import { Hono } from 'hono';
import { Context } from 'hono/context';

const app = new Hono();

app.delete('/upload/metadata/:id', async (c: Context) => {
  const id = c.req.param('id');
  await c.env.D1.run('DELETE FROM metadata WHERE id = ?', [id]);
  return c.json({ message: 'Metadata removed successfully' });
});

export default app;
