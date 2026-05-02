import { Hono } from 'hono';
import { z } from 'zod';

const audioRoute = new Hono();

const audioSchema = z.object({
  filename: z.string(),
});

audioRoute.get('/audio/:filename', async (c) => {
  const { filename } = c.req.param();
  try {
    // Lógica para retornar o arquivo de áudio
    return c.json({ message: 'Áudio enviado com sucesso' });
  } catch (e) {
    return c.json({ error: 'Erro ao enviar áudio' }, 500);
  }
});

export default audioRoute;
