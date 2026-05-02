import { Hono } from 'hono';
import { c } from '../_utils';
const app = new Hono();
app.get('/passdriver', async (c) => {
  return c.json({ message: 'PassDriver funcionando!' });
});
