import { Router } from 'hono';
import { deployRouter } from './deploy/deploy.routes';

export const router = new Router();

router.use('/deploy/*', deployRouter);
