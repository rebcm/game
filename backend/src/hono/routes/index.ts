import { Hono } from 'hono';
import { validateCloudflareSecrets } from '../middlewares/validate-cloudflare-secrets';
const app = new Hono();
app.use('*', validateCloudflareSecrets);
// existing routes...
