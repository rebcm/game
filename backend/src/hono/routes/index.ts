import { Hono } from 'hono';
import passdriverRoute from './passdriver/passdriver_route';

const routes = new Hono();
routes.route('/api', passdriverRoute);

export default routes;
