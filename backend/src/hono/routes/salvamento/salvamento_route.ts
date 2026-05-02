import { Hono } from 'hono';
import { salvamentoController } from './salvamento_controller';

const salvamentoRoute = new Hono()
  .get('/salvamento', salvamentoController.getSalvamento)
  .post('/salvamento', salvamentoController.createSalvamento);

export { salvamentoRoute };
