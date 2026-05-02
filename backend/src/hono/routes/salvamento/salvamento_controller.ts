import { Hono } from 'hono';
import { c } from 'hono/cloudflare';

class SalvamentoController {
  async getSalvamento(c) {
    const mundo = await c.env.DB.prepare('SELECT * FROM mundos');
    return c.json(mundo);
  }

  async createSalvamento(c) {
    const mundo = await c.request.json();
    await c.env.DB.prepare('INSERT INTO mundos (nome, descricao) VALUES (?, ?)', [mundo.nome, mundo.descricao]);
    return c.json({ message: 'Mundo criado com sucesso!' }, 201);
  }
}

export { SalvamentoController };
