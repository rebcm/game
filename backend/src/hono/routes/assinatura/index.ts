import { Hono } from 'hono';
import { validateAssinatura } from './assinatura_controller';

const app = new Hono();

app.post('/assinatura/validar', validateAssinatura);

export default app;
