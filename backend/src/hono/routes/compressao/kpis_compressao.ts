import { Hono } from 'hono';
import { Context } from 'hono';

const app = new Hono();

app.get('/compressao/kpis', async (c: Context) => {
  const bitrateMinimo = 128; // kbps
  const tamanhoBinarioOriginal = 1024; // bytes
  const tamanhoBinarioComprimido = 512; // bytes
  const taxaCompressao = (tamanhoBinarioComprimido / tamanhoBinarioOriginal) * 100;

  return c.json({
    bitrateMinimo,
    tamanhoBinarioOriginal,
    tamanhoBinarioComprimido,
    taxaCompressao,
  });
});

export default app;
