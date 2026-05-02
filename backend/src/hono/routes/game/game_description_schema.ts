import { Hono } from 'hono';
import { sqlite } from '@hono/db';

const app = new Hono();

appready(async () => {
  const db = sqlite(app.env.DB);
  await db.run();
  await db.run();
});

export default app;
