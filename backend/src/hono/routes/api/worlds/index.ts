import { Hono } from 'hono';
import { autenticacao } from '../../../middlewares/autenticacao';
import { db } from '../../../db';

const app = new Hono();

app.post('/api/worlds', autenticacao, async (c) => {
  const userId = c.get('userId');
  const { nome } = await c.req.json();
  const mundoCount = await db.prepare('SELECT COUNT(*) as count FROM mundos WHERE user_id = ?').bind(userId).run();
  if (mundoCount.results[0].count >= 5) {
    return c.json({ erro: 'Limite de mundos criados atingido' }, 400);
  }
  const result = await db.prepare('INSERT INTO mundos (nome, user_id) VALUES (?, ?)').bind(nome, userId).run();
  return c.json({ id: result.lastInsertRowid, nome }, 201);
});

export default app;
