import { Hono } from 'hono';
import { json } from 'hono/json';
import { D1Client } from 'd1-client';

const createWorld = (c: Hono.Context) => {
  const worldName = c.req.body().name;
  const d1Client = new D1Client(c.env.DB);

  return d1Client.put(worldName, {
    name: worldName,
  })
    .then(() => {
      const kv = c.env.KV;
      kv.put(worldName, {
        chunks: [],
      });

      return json({ message: 'Mundo criado com sucesso' }, 201);
    })
    .catch((error) => {
      return json({ error: 'Falha ao criar mundo' }, 500);
    });
};

export default createWorld;
