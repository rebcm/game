import { Hono } from 'hono';
import { sign } from 'hono/jwt';

const app = new Hono();

app.post('/api/auth/login', async c => {
  const { email, password } = await c.req.json();
  // Implement authentication logic here
  const token = await sign({ email }, c.env.JWT_SECRET, {
    expiresIn: '30d',
  });
  return c.json({ token });
});

export default app;
