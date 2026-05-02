import { Hono } from 'hono';
import { Context } from 'hono';
const app = new Hono();
app.get('/rebeca', async (c: Context) => {
  return c.json({ descricao: 'Rebeca é uma personagem com um estilo único e uma aparência marcante.' });
});
export default app;
