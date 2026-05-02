import { Hono } from 'hono';
import { Context } from 'hono';
import { env } from 'hono/adapter';

const app = new Hono();

app.get('/test_integration/cleanup', async (c: Context) => {
  const { DB } = env<object>(c);
  await DB.prepare('DELETE FROM table_name WHERE condition').run();
  return c.text('Cleanup realizado com sucesso');
});

export default app;
