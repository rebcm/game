import { Hono } from 'hono';
import { handle } from 'hono/cloudflare-workers';

const app = new Hono();

app.get('/pipeline-test', (c) => {
  return c.text('Pipeline funcionando corretamente!');
});

export default handle(app);
