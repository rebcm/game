import { Router } from 'hono';
import { c } from 'hono/cloudflare';

const audioRouter = new Router();

audioRouter.get('/optimize', (c) => {
  c.env.KV.put('audio_optimized', 'true');
  return 'Áudio otimizado com sucesso!';
});

export { audioRouter };
