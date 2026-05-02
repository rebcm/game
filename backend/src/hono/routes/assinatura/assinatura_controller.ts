import { Context } from 'hono';
import { createHmac } from 'crypto';

export const validateAssinatura = async (c: Context) => {
  const { apk, checksum } = await c.req.json();
  const computedChecksum = createHmac('sha256', apk).digest('hex');
  if (computedChecksum !== checksum) {
    return c.json({ error: 'Assinatura inválida' }, 401);
  }
  return c.json({ message: 'Assinatura válida' });
};
