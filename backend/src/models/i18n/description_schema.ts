import { z } from 'zod';

export const descriptionSchema = z.object({
  description: z.string().min(10, 'Descrição deve ter pelo menos 10 caracteres'),
});
