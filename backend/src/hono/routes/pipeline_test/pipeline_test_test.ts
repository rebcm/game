import { describe, it, expect } from 'vitest';
import app from './pipeline_test_route';

describe('Pipeline test route', () => {
  it('should return success message', async () => {
    const res = await app.request('/pipeline-test');
    expect(res.status).toBe(200);
    expect(await res.text()).toBe('Pipeline backend executado com sucesso');
  });
});
