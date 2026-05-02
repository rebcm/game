import { Hono } from 'hono';

const retryRoute = new Hono();

retryRoute.post('/retry', async (c) => {
  try {
    // Simulate a transient error
    if (Math.random() < 0.5) {
      return c.json({ error: 'Erro transitório' }, 503);
    }

    return c.json({ message: 'Operação realizada com sucesso' });
  } catch (e) {
    return c.json({ error: 'Erro ao realizar operação' }, 500);
  }
});

export default retryRoute;
