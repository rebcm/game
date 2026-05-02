import { Hono } from 'hono';
import { authenticationRoute } from '../authentication';
import { mockRequest } from '../../../../test/helpers';

describe('Authentication route', () => {
  it('should return 401 when authentication fails', async () => {
    const c = mockRequest({ username: 'username', password: 'wrong_password' });
    const response = await authenticationRoute(c);
    expect(response.status).toBe(401);
  });

  it('should return 507 when storage limit is reached', async () => {
    const c = mockRequest({ username: 'username', password: 'password' });
    c.env.KV.get = async () => 'true';
    const response = await authenticationRoute(c);
    expect(response.status).toBe(507);
  });
});
