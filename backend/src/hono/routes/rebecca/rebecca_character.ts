import { Hono } from 'hono';

const rebeccaCharacterRoute = new Hono();

rebeccaCharacterRoute.get('/rebecca', (c) => {
  const character = {
    description: 'Personagem principal da história',
    appearance: 'Cabelos castanhos, olhos azuis',
    style: 'Moderno e elegante',
  };

  return c.json(character);
});

export default rebeccaCharacterRoute;
