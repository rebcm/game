import { Hono } from 'hono';
import { sqlite } from 'sqlite';
import { Database } from 'sqlite3';

const app = new Hono();

app.post('/api/auth/login', async (c) => {
  const { email, password } = await c.req.json();
  const db = new Database(c.env.DB);
  const query = 'SELECT * FROM users WHERE email = ? AND password = ?';
  const params = [email, password];
  const result = await db.get(query, params);
  if (result) {
    const token = await generateToken(result);
    return c.json({ token }, 200);
  } else {
    return c.json({ error: 'Credenciais inválidas' }, 401);
  }
});

async function generateToken(user) {
  const token = await crypto.subtle.generateKey(
    {
      name: 'HMAC',
      hash: 'SHA-256',
    },
    true,
    ['sign'],
  );
  const payload = {
    userId: user.id,
    exp: Math.floor(Date.now() / 1000) + 30 * 24 * 60 * 60,
  };
  const encodedPayload = Buffer.from(JSON.stringify(payload), 'utf8').toString('base64');
  const signature = await crypto.subtle.sign(
    {
      name: 'HMAC',
      hash: 'SHA-256',
    },
    token,
    Buffer.from(encodedPayload, 'base64'),
  );
  return ;
}
