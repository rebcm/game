import { Context, Next } from 'hono';
import { verify } from 'hono/jwt';

const validateJWT = async (c: Context, next: Next) => {
  const jwt = c.req.header('Authorization')?.replace('Bearer ', '');
  if (!jwt) {
    return c.json({ error: 'Token de autenticação não fornecido' }, 401);
  }

  try {
    const secret = c.env.JWT_SECRET;
    await verify(jwt, secret);
    await next();
  } catch (err) {
    return c.json({ error: 'Token de autenticação inválido' }, 401);
  }
};

export default validateJWT;
