import { Context } from 'hono';
export const validateCloudflareSecrets = async (c: Context) => {
  const apiToken = c.env.CLOUDFLARE_API_TOKEN;
  const accountId = c.env.CLOUDFLARE_ACCOUNT_ID;
  if (!apiToken || !accountId) {
    return c.text('Cloudflare secrets não estão configurados', 500);
  }
  return await c.next();
};
