import { Hono } from 'hono';
import { Context } from 'hono';

const app = new Hono();

app.get('/pipeline-test', async (c: Context) => {
  return c.text('Pipeline backend executado com sucesso');
});

export default app;
