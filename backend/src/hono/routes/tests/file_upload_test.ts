import { Hono } from 'hono';
import { fileUploadRoute } from '../file_upload';

const app = new Hono();

app.route('/files', fileUploadRoute);

describe('File Upload Route', () => {
  it('should upload file', async () => {
    const file = new File(['test content'], 'test_file.txt');
    const res = await app.request('/files', {
      method: 'POST',
      body: file,
    });
    expect(res.status).toBe(201);
    const uploadedFiles = await app.request('/files');
    expect(uploadedFiles.json().length).toBe(1);
  });
});
