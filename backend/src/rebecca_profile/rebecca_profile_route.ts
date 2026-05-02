import { Hono } from 'hono';
import { Context } from 'hono';

const app = new Hono();

app.get('/rebecca-profile', async (c: Context) => {
  const character = {
    description: 'Rebeca é uma personagem carismática e determinada.',
    appearance: 'Ela tem cabelos castanhos e olhos verdes.',
    style: 'Seu estilo é moderno e sofisticado.',
  };

  return c.json(character);
});

export default app;
