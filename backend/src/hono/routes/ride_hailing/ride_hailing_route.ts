import { Hono } from 'hono';
import { Context } from 'hono';

const rideHailingRoute = new Hono();

rideHailingRoute.get('/ride_hailing/chunk_size', async (c: Context) => {
  const chunkSize = await c.env.KV.get('chunk_size');
  return c.json({ chunkSize: chunkSize ? parseInt(chunkSize) : 10 });
});

rideHailingRoute.post('/ride_hailing/chunk_size', async (c: Context) => {
  const { size } = await c.req.json();
  await c.env.KV.put('chunk_size', size.toString());
  return c.json({ message: 'Tamanho do chunk atualizado com sucesso' });
});

export default rideHailingRoute;
