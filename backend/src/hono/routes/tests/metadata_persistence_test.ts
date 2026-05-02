import { Hono } from 'hono';
import { metadataPersistenceRoute } from '../metadata_persistence';

const app = new Hono();

app.route('/metadata', metadataPersistenceRoute);

describe('Metadata Persistence Route', () => {
  it('should persist metadata', async () => {
    const metadata = { key: 'value' };
    const res = await app.request('/metadata', {
      method: 'POST',
      body: JSON.stringify(metadata),
    });
    expect(res.status).toBe(201);
    const persistedMetadata = await app.request('/metadata');
    expect(persistedMetadata.json()).toEqual(metadata);
  });
});
