import { Context } from 'hono';
export const validateCloudflareSecrets = async (c: Context, next: () => Promise<void>) => {
  const apiToken = c.env.CLOUDFLARE_API_TOKEN;
  const accountId = c.env.CLOUDFLARE_ACCOUNT_ID;
  if (!apiToken || !accountId) {
    return c.text('Erro: Variáveis de ambiente do Cloudflare não configuradas', 500);
  }
  await next();
};
