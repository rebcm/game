import { Context, Next } from 'hono';

const authenticateAndValidate = async (c: Context, next: Next) => {
  const userId = c.get('userId');
  if (!userId) {
    return c.json({ error: 'Usuário não autenticado' }, 401);
  }

  const userWorldsCount = await c.env.DB.prepare('SELECT COUNT(*) as count FROM worlds WHERE user_id = ?').bind(userId).run();
  const maxWorlds = 5; // Limite máximo de mundos por usuário
  if (userWorldsCount.results[0].count >= maxWorlds) {
    return c.json({ error: 'Limite de mundos criados atingido' }, 400);
  }

  await next();
};

export default authenticateAndValidate;
