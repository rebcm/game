import { describe, it, expect } from 'vitest';
import app from './configuracoes_ambiente_route';

describe('GET /configuracoes-ambiente', () => {
  it('deve retornar ambiente', async () => {
    const env = { KV: { get: () => 'producao' } };
    const c = { env, json: (data: any) => ({ data }) };
    const response = await app.request('/configuracoes-ambiente', {}, c);
    expect(await response.json()).toEqual({ ambiente: 'producao' });
  });
});
