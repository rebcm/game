import { Hono } from 'hono';
import { Context } from 'hono';

const app = new Hono();

app.post('/upload/:fileId', async (c: Context) => {
  const fileId = c.req.param('fileId');
  const chunk = await c.req.arrayBuffer();

  try {
    // upload para o R2
    await c.env.R2.put(, chunk);
    return c.text('OK', 200);
  } catch (e) {
    // marca o estado como 'incompleto' no D1
    await c.env.DB.prepare('UPDATE uploads SET status = ? WHERE id = ?')
      .bind('incompleto', fileId)
      .run();
    return c.text('Erro ao fazer upload', 500);
  }
});

app.delete('/upload/:fileId', async (c: Context) => {
  const fileId = c.req.param('fileId');

  try {
    // remove o metadado correspondente no D1
    await c.env.DB.prepare('DELETE FROM uploads WHERE id = ?')
      .bind(fileId)
      .run();
    // remove os chunks do R2
    await c.env.R2.delete();
    return c.text('OK', 200);
  } catch (e) {
    return c.text('Erro ao cancelar upload', 500);
  }
});

export default app;
