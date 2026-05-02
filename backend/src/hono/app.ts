import { Hono } from 'hono';
import controles from './routes/controles/controles';

const app = new Hono();

app.route('/api', controles);

export default app;
