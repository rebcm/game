import { Hono } from 'hono';
import fisicaRoute from './routes/fisica/route';

const app = new Hono();

app.route('/fisica', fisicaRoute);

export default app;
