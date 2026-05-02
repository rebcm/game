import { Hono } from 'hono';

const app = new Hono();

app.get('/validate-cloudflare', async (c) => {
  const cloudflareApiToken = c.env.CLOUDFLARE_API_TOKEN;
  const cloudflareAccountId = c.env.CLOUDFLARE_ACCOUNT_ID;

  if (!cloudflareApiToken || !cloudflareAccountId) {
    return c.text('Erro: CLOUDFLARE_API_TOKEN ou CLOUDFLARE_ACCOUNT_ID não configurado', 500);
  }

  return c.text('CLOUDFLARE_API_TOKEN e CLOUDFLARE_ACCOUNT_ID configurados corretamente');
});

export default app;
