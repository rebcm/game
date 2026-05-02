import { Router } from 'hono';
import { c } from '../utils/constants';

const configureSecretsRoute = new Router();

configureSecretsRoute.post('/configure-secrets', (c) => {
  const { cloudflareApiToken, cloudflareAccountId } = c.req.body;
  c.env.CLOUDFLARE_API_TOKEN = cloudflareApiToken;
  c.env.CLOUDFLARE_ACCOUNT_ID = cloudflareAccountId;
  return c.json({ message: 'Configuração concluída com sucesso!' }, 200);
});

export default configureSecretsRoute;
