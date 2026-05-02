import { Hono } from 'hono';
import { Context } from 'hono';

const app = new Hono();

app.post('/purge_test', async (c: Context) => {
  try {
    // Implementar lógica de teste de purga aqui
    return c.json({ message: 'Teste de purga executado com sucesso' }, 200);
  } catch (error) {
    return c.json({ message: 'Erro ao executar teste de purga' }, 500);
  }
});

export default app;
