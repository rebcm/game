import { Hono } from 'hono';
import { TransitionState } from '../../models/transition_state';

const app = new Hono();

app.get('/transitions', async (c) => {
  const state = await c.env.KV.get('transition_state');
  return c.json({ state });
});

app.post('/transitions', async (c) => {
  const { state } = await c.req.json();
  await c.env.KV.put('transition_state', state);
  return c.json({ message: 'Transition state updated' });
});

export default app;
