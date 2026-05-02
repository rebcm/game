import { Router } from '@hono/router';
import { c } from '@hono/core';

const router = new Router();

router.get('/3d-engine', async (c) => {
  return c.text('3D Engine');
});

export default router;
