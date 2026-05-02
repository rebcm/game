import { Hono } from 'hono';
import { Context } from 'hono/context';

const app = new Hono();

app.post('/upload', async (c: Context) => {
  const fileBuffer = await c.req.arrayBuffer();
  const fileChecksum = await _calculateChecksum(fileBuffer);
  await c.env.DB.prepare('INSERT INTO uploads (status, checksum) VALUES (?, ?)').run('uploaded', fileChecksum);
  return c.json({ message: 'Arquivo enviado com sucesso' }, 201);
});

async function _calculateChecksum(fileBuffer: ArrayBuffer) {
  // implement checksum calculation logic here
  return 'checksum';
}

export default app;
