import { Hono } from 'hono';
import { Context } from 'hono/context';

const app = new Hono();

app.post('/upload_test', async (c: Context) => {
  // Implementar lógica de tratamento de upload de arquivo aqui
  return c.json({ message: 'Arquivo recebido com sucesso' });
});

export default app;
