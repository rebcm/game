import { Hono } from 'hono';
import renderizacao3D from './routes/renderizacao_3d';

const app = new Hono();

app.route('/api/renderizacao-3d', renderizacao3D);

export default app;
