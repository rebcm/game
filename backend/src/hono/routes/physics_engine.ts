import { Router } from '@hono/router';
import { c } from '@hono/core';

const router = new Router();

router.get('/physics-engine', async (c) => {
  return c.text('Physics Engine');
});

export default router;
