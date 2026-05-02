import { Hono } from 'hono';
import integracaoPassdriver from './routes/integracao_passdriver';

const app = new Hono();

app.route('/api', integracaoPassdriver);

export default app;
