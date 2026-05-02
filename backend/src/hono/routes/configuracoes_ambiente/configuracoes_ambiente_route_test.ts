import { describe, it, expect } from 'vitest';
import app from './configuracoes_ambiente_route';

describe('ConfiguracoesAmbienteRoute', () => {
  it('deve retornar ambiente atual', async () => {
    const c = {
      env: {
        KV: {
          get: async () => 'producao',
        },
      },
      json: async (data: any) => data,
    };
    const response = await app.request('/configuracoes-ambiente', { method: 'GET', c });
    expect(response).toEqual({ ambiente: 'producao' });
  });

  it('deve atualizar ambiente', async () => {
    const c = {
      env: {
        KV: {
          put: async () => {},
        },
      },
      req: {
        json: async () => ({ ambiente: 'homologacao' }),
      },
      json: async (data: any) => data,
    };
    const response = await app.request('/configuracoes-ambiente', { method: 'POST', c });
    expect(response).toEqual({ message: 'Ambiente atualizado com sucesso' });
  });
});
