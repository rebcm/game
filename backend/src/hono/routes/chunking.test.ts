import { Hono } from 'hono';
import { chunkingRoute } from './chunking';

const app = new Hono();

app.route('/chunking', chunkingRoute);

describe('chunking route', () => {
  it('should handle chunking requests', async () => {
    // implement test logic here
  });
});
