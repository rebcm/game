import { z } from 'zod';

export const threeDObjectSchema = z.object({
  id: z.string(),
  data: z.string(),
});
