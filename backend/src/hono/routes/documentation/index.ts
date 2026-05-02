import { Hono } from 'hono';
import { markdown } from '@hono/hono/markdown';
const documentationRoute = new Hono();
documentationRoute.get('/pipeline', async (c) => {
  const pipelineDoc = await Deno.readTextFile('./docs/pipeline.md');
  return c.html(markdown(pipelineDoc));
});
export default documentationRoute;
