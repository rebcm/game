import { Hono } from 'hono';
import { Context } from 'hono';
import { env } from 'hono/adapter';
import { R2Bucket } from '@cloudflare/workers-types';

const r2 = async (c: Context) => {
  const { R2_BUCKET_NAME } = env(c);
  const bucket: R2Bucket = c.env[R2_BUCKET_NAME];

  const listObjects = await bucket.list({
    prefix: R2_CHUNK_PREFIX,
  });

  return c.json(listObjects.objects.map((obj) => obj.key));
};

export default r2;
