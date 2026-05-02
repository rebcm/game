import { describe, it, expect } from 'vitest';
import app from './upload_test_route';

describe('UploadTestRoute', () => {
  it('should return 200 on successful upload', async () => {
    const response = await app.request('/upload_test', {
      method: 'POST',
      body: new Blob(['file contents'], { type: 'text/plain' }),
    });
    expect(response.status).toBe(200);
  });
});
