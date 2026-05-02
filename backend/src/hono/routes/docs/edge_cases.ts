import { Hono } from 'hono';
import { Context } from 'hono';
const app = new Hono();
app.get('/edge-cases', async (c: Context) => {
  return c.json([
    { title: 'Colisões em alta velocidade (tunneling)' },
    { title: 'Compressão de objetos entre paredes' },
    { title: 'Comportamento de empilhamento de itens físicos' }
  ]);
});
export default app;
