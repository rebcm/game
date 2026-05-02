import { Hono } from 'hono';
import { getChunkKey } from './chunk-naming';

const r2 = new Hono();

r2.get('/r2/chunk/:chunkName/:version', async (c) => {
  const chunkName = c.req.param('chunkName');
  const version = c.req.param('version');
  const key = getChunkKey(version, chunkName);
  const object = await c.env.R2.get(key);
  if (!object) {
    return c.text('Chunk não encontrado', 404);
  }
  return c.body(object.body, {
    headers: {
      'Content-Disposition': `attachment; filename=${key}`,
      'Content-Type': 'application/octet-stream',
    },
  });
});

export default r2;
