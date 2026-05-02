import { Hono } from 'hono';
import apiTestRoute from './api-test/api-test-route';

const routes = new Hono();
routes.route('/', apiTestRoute);

export default routes;
