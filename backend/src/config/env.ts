import { Env } from '../hono';

interface Config {
  DB: D1Database;
  KV: KVNamespace;
}

const getConfig = (c: Context): Config => {
  return {
    DB: c.env.DB,
    KV: c.env.KV,
  };
};

export default getConfig;
