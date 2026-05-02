import { Hono } from 'hono';
import { Context } from 'hono';

const app = new Hono();

app.get('/exemplo', async (c: Context) => {
  try {
    // Simular resposta do servidor
    throw c.json({ mensagem: 'Requisição interceptada com sucesso' }, 200);
  } catch (e) {
    return c.json({ mensagem: 'Erro ao processar requisição' }, 500);
  }
});

export default app;
