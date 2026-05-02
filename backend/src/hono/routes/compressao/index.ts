import { Hono } from 'hono';
import compressao from './compressao/kpis_compressao';

const app = new Hono();

app.route('/compressao', compressao);

export default app;
