import { Hono } from 'hono';

const app = new Hono();

const authenticateAndValidate = async (c: any, next: any) => {
  const userId = c.req.header('user-id');
  if (!userId) {
    return c.json({ error: 'Usuário não identificado' }, 401);
  }

  const userWorldsCount = await c.env.DB.prepare('SELECT COUNT(*) as count FROM worlds WHERE user_id = ?').bind(userId).run();
  const maxWorlds = 5; // TO BE FETCHED FROM CONFIG OR DB
  if (userWorldsCount.results[0].count >= maxWorlds) {
    return c.json({ error: 'Limite de mundos criados atingido' }, 400);
  }

  await next();
};

export default authenticateAndValidate;
