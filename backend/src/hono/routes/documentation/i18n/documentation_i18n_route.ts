import { Hono } from 'hono';
import { Context } from 'hono';

const documentationI18nRoute = new Hono();

documentationI18nRoute.get('/:lang', async (c: Context) => {
  const lang = c.req.param('lang');
  const documentationContent = await c.env.KV.get(`documentation_${lang}`);

  if (!documentationContent) {
    return c.text('Conteúdo não encontrado', 404);
  }

  return c.text(documentationContent);
});

export default documentationI18nRoute;
