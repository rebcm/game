import { Hono } from 'hono';
import testIntegration from './test_integration/cleanup';

const app = new Hono();
app.route('/test_integration', testIntegration);

export default app;
