import { Hono } from 'hono';
import { Router } from './router';

const chunkRouter = new Router();

chunkRouter.get('/:id/chunks/:x/:z', async (c) => {
  const id = c.req.param('id');
  const x = parseInt(c.req.param('x'));
  const z = parseInt(c.req.param('z'));
  const chunks = await c.env.KV.get('chunks', { id, x, z });
  if (chunks) {
    return c.json(chunks);
  } else {
    return c.text('Chunks não encontrados', 404);
  }
});

chunkRouter.put('/:id/chunks/:x/:z', async (c) => {
  const id = c.req.param('id');
  const x = parseInt(c.req.param('x'));
  const z = parseInt(c.req.param('z'));
  const chunk = await c.req.json();
  await c.env.KV.put('chunks', { id, x, z }, chunk);
  return c.text('Chunk salvo com sucesso');
});

export default chunkRouter;
