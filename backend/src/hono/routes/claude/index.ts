import { Hono } from 'hono';
const claudeRoute = new Hono();
claudeRoute.get('/', (c) => c.text('CLAUDE'));
export default claudeRoute;
