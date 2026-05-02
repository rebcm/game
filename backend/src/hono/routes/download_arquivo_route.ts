import { Hono } from 'hono';
import { Context } from 'hono';

const app = new Hono();

app.get('/download_arquivo', async (c: Context) => {
  try {
    // Lógica para download do arquivo
    return c.text('Arquivo baixado com sucesso', 200);
  } catch (e) {
    return c.text('Erro ao baixar arquivo', 500);
  }
});

export default app;
