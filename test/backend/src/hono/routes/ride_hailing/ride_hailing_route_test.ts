import { test } from '@jest/globals';
import app from '../../../../src/hono/routes/ride_hailing/ride_hailing_route';

describe('RideHailingRoute', () => {
  test('should return 408 when request timeout occurs', async () => {
    const res = await app.request('/ride_hailing/data', { timeout: 1000 });
    expect(res.status).toBe(408);
  });
});
