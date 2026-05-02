import { Hono } from 'hono';
import { Context } from 'hono/context';

const app = new Hono();

app.post('/upload/chunk', async (c: Context) => {
  try {
    const { chunk, metadataId } = await c.req.json();
    await c.env.R2.uploadChunk(chunk, metadataId);
    return c.json({ message: 'Chunk uploaded successfully' });
  } catch (e) {
    await c.env.D1.run('UPDATE metadata SET status = ? WHERE id = ?', ['incompleto', metadataId]);
    return c.json({ message: 'Falha no upload do chunk' }, 500);
  }
});

export default app;
