import { Hono } from 'hono';
import { Context } from 'hono';

const criativoRoute = new Hono();

criativoRoute.get('/criativo/voar', async (c: Context) => {
  const voar = await c.env.KV.get('voar');
  return c.json({ voar: voar === 'true' });
});

criativoRoute.post('/criativo/voar', async (c: Context) => {
  const { voar } = await c.req.json();
  await c.env.KV.put('voar', voar.toString());
  return c.json({ message: 'Estado de voar atualizado' });
});

criativoRoute.get('/criativo/pular', async (c: Context) => {
  const pular = await c.env.KV.get('pular');
  return c.json({ pular: pular === 'true' });
});

criativoRoute.post('/criativo/pular', async (c: Context) => {
  const { pular } = await c.req.json();
  await c.env.KV.put('pular', pular.toString());
  return c.json({ message: 'Estado de pular atualizado' });
});

export default criativoRoute;
