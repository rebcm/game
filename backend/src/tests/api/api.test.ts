import { Hono } from 'hono';
import { app } from '../hono/app';

describe('API Tests', () => {
  it('GET request test', async () => {
    const res = await app.request('https://api.passdriver.com/test');
    expect(res.status).toBe(200);
  });

  it('POST request test', async () => {
    const res = await app.request('https://api.passdriver.com/test', {
      method: 'POST',
      body: JSON.stringify({ key: 'value' }),
      headers: { 'Content-Type': 'application/json' },
    });
    expect(res.status).toBe(201);
  });
});
