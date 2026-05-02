import { test } from 'vitest';
import { app } from '../../../../src/hono/app';
import { createTestClient } from 'hono/testing';

test('upload timeout test', async () => {
  const client = createTestClient(app);
  const res = await client.post('/upload', {
    body: 'test_file.txt',
    headers: { 'Content-Type': 'application/octet-stream' },
  }, {
    fetch: (url, options) => {
      return new Promise((resolve) => {
        setTimeout(() => {
          resolve(new Response(null, { status: 408 }));
        }, 100);
      });
    },
  });
  expect(res.status).toBe(408);
});

test('upload connection failure test', async () => {
  const client = createTestClient(app);
  try {
    await client.post('/upload', {
      body: 'test_file.txt',
      headers: { 'Content-Type': 'application/octet-stream' },
    }, {
      fetch: () => {
        throw new Error('Connection failed');
      },
    });
    expect.unreachable();
  } catch (error) {
    expect(error.message).toBe('Connection failed');
  }
});
