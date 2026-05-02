import { Context } from 'hono';

export const test = async (c: Context) => {
  return c.json({ message: 'OK' }, 200);
};
