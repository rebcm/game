import { Hono } from 'hono';
import api from './api/data';

const app = new Hono();

app.route('/api', api);

export default app;
