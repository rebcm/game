import { Hono } from 'hono';
import { Context } from 'hono';
const app = new Hono();
app.get('/data_mapping', async (c: Context) => {
  return c.json({ message: 'Mapeamento de Requisitos de Dados' });
});
export default app;
