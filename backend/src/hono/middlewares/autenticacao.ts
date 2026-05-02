import { Context, Next } from 'hono';

export async function autenticacao(c: Context, next: Next) {
  const token = c.req.headers.get('Authorization');
  if (!token) {
    return c.json({ erro: 'Usuário não autenticado' }, 401);
  }
  // Implementar lógica de validação do token
  await next();
}
