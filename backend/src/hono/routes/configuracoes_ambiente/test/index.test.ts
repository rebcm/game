import { describe, expect, it } from 'vitest';
import app from '../index';

describe('GET /configuracoes-ambiente', () => {
  it('should return ambiente', async () => {
    const c = {
      env: {
        KV: {
          get: async () => 'producao',
        },
      },
      json: async (data: any) => data,
    };
    const response = await app.request('/configuracoes-ambiente', { method: 'GET' }, c);
    expect(response).toEqual({ ambiente: 'producao' });
  });
});

describe('POST /configuracoes-ambiente', () => {
  it('should update ambiente', async () => {
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
    const response = await app.request('/configuracoes-ambiente', { method: 'POST' }, c);
    expect(response).toEqual({ ambiente: 'homologacao' });
  });
});
