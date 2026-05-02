import { Hono } from 'hono';
import { Context } from 'hono';

const app = new Hono();

app.post('/upload', async (c: Context) => {
  const { fileChecksum, fileStatus } = await c.req.json();
  const db = c.env.DB;
  await db.prepare('UPDATE uploads SET status = ? WHERE checksum = ?').run(fileStatus, fileChecksum);
  return c.json({ message: 'Upload status updated successfully' });
});

export default app;
