import { Router } from 'itty-router';
import { handleGetWorlds } from './handlers/get-worlds.js';

const router = Router();

router.get('/api/worlds', handleGetWorlds);

export default {
  async fetch(request, env) {
    return router.fetch(request, env);
  },
};
