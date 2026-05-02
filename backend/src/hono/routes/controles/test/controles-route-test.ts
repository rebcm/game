import { Hono } from 'hono';
import { controles } from './controles';

const app = new Hono();

app.get('/controles/validar', async (c) => {
  const resultado = await controles.validarCritériosDeAceitação(c.env.DB);
  if (resultado) {
    return c.json({ mensagem: 'Critérios de aceitação válidos' }, 200);
  } else {
    return c.json({ mensagem: 'Critérios de aceitação inválidos' }, 400);
  }
});

export default app;
