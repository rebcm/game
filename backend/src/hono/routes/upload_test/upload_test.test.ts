import { describe, it, expect } from 'vitest';
import app from './index';

describe('Upload test route', () => {
  it('should return 200 for valid file', async () => {
    const file = new Uint8Array(1024 * 1024); // 1MB file
    const response = await app.request('/api/upload', {
      method: 'POST',
      headers: { 'Content-Type': 'application/octet-stream' },
      body: file,
    });
    expect(response.status).toBe(200);
  });

  it('should return 413 for large file', async () => {
    const file = new Uint8Array(11 * 1024 * 1024); // 11MB file
    const response = await app.request('/api/upload', {
      method: 'POST',
      headers: { 'Content-Type': 'application/octet-stream' },
      body: file,
    });
    expect(response.status).toBe(413);
  });
});
