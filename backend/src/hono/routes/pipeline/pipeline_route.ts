import { Router } from '@honojs/router';
import { c } from '../context';

const router = new Router();

router.get('/pipeline', async (c) => {
  return new Response('Pipeline de CI/CD em execução', {
    status: 200,
    headers: {
      'Content-Type': 'text/plain',
    },
  });
});

export default router;
