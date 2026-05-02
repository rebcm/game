import { Hono } from 'hono';
import { z } from 'zod';

const dependenciesValidationRoute = new Hono();

dependenciesValidationRoute.get('/dependencies-validation', async (c) => {
  const db = c.env.DB;
  const result = await db.prepare('SELECT * FROM dependencies').all();
  return c.json(result.results);
});

export default dependenciesValidationRoute;
