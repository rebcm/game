import { Router } from 'hono';
import { c } from '../utils/constants';

const deployRouter = new Router();

deployRouter.get('/deploy', (c) => {
  return 'Deploy para Cloudflare Pages';
});

export { deployRouter };
