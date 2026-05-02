import { test } from '@cloudflare/workers-types';
import { Hono } from 'hono';
import { jogoRoute } from './jogo';

test('jogo route test', async () => {
  const app = new Hono();
  app.route('/jogo', jogoRoute);
  // Implement test logic here
});
