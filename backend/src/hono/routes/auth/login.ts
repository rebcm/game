import { Hono } from 'hono';
import { sign } from 'hono/jwt';

const auth = new Hono();

auth.post('/login', async c => {
  const { email, password } = await c.req.json();
  // Implement authentication logic here
  const user = { id: '1', email };
  const token = await sign({ id: user.id, exp: Math.floor(Date.now() / 1000) + 30 * 24 * 60 * 60 }, c.env.SECRET_KEY);
  return c.json({ token });
});

export default auth;
