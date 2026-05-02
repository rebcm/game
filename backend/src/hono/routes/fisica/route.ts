import { Hono } from 'hono';
import { Context } from 'hono';

const fisicaRoute = new Hono();

fisicaRoute.get('/objetos', async (c: Context) => {
  const objetos = await c.env.DB.prepare('SELECT * FROM objetos_3d').all();
  return c.json(objetos.results);
});

fisicaRoute.post('/objetos', async (c: Context) => {
  const objeto = await c.req.json();
  await c.env.DB.prepare('INSERT INTO objetos_3d (x, y, z) VALUES (?, ?, ?)').run(objeto.x, objeto.y, objeto.z);
  return c.json({ message: 'Objeto adicionado com sucesso' });
});

export default fisicaRoute;
