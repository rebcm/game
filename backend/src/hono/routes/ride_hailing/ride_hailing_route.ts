import { Hono } from 'hono';
import { logger } from 'hono/logger';

const app = new Hono();

app.use('*', logger());

app.post('/ride_hailing', async (c) => {
  try {
    // existing route logic
  } catch (error) {
    if (error instanceof AuthenticationError) {
      return c.json({ error: 'Erro de autenticação' }, 401);
    } else if (error instanceof TimeoutError) {
      return c.json({ error: 'Timeout' }, 408);
    } else if (error instanceof PayloadLimitError) {
      return c.json({ error: 'Limite de payload excedido' }, 413);
    }
  }
});

export default app;
