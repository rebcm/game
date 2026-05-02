import { describe, it, expect } from 'vitest';
import retryPolicy from './retry_policy';

describe('retryPolicy', () => {
  it('retorna true para timeout', async () => {
    expect(await retryPolicy(null, 'timeout')).toBe(true);
  });

  it('retorna true para connection_error', async () => {
    expect(await retryPolicy(null, 'connection_error')).toBe(true);
  });

  it('retorna false para outros erros', async () => {
    expect(await retryPolicy(null, 'outro_erro')).toBe(false);
  });
});
