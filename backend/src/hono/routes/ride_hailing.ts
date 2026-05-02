import { Hono } from 'hono';
import { z } from 'zod';

const rideHailingSchema = z.object({
  lat: z.number(),
  lng: z.number(),
});

const app = new Hono();

app.post('/ride_hailing', async (c) => {
  const { lat, lng } = await c.req.json();
  const validatedData = rideHailingSchema.parse({ lat, lng });
  // Save to D1 SQLite or KV
  return c.json({ message: 'Rota criada com sucesso' }, 201);
});

export default app;
