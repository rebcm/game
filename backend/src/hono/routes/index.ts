import { Hono } from 'hono';
import iluminacaoRoute from './iluminacao/iluminacao_route';

const app = new Hono();

app.route('/api', iluminacaoRoute);

export default app;
