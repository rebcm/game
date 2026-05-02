import { Hono } from 'hono';
import { Context } from 'hono/context';

const app = new Hono();

app.post('/api/upload', async (c: Context) => {
  try {
    const file = await c.req.arrayBuffer();
    if (file.byteLength > 10 * 1024 * 1024) {
      return c.text('Arquivo muito grande', 413);
    }
    // Process the file
    return c.text('Arquivo enviado com sucesso', 200);
  } catch (e) {
    return c.text('Erro ao processar arquivo', 500);
  }
});

export default app;
