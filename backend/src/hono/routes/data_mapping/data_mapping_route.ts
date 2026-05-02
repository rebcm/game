import { Hono } from 'hono';
import { Context } from 'hono';

const dataMappingRoute = new Hono();

dataMappingRoute.get('/data-mapping', async (c: Context) => {
  // TO BE IMPLEMENTED
  return c.json({});
});

export default dataMappingRoute;
