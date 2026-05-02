import { Hono } from 'hono';
import retryPolicy from './retry_policy_middleware';

const app = new Hono();
app.use('/api/*', retryPolicy);

export default app;
