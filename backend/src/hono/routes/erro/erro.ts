import { Context } from 'hono';
import { logger } from '../../utils/logger';
export const erroRoute = async (c: Context) => {
  try {
    // Lógica para tratar erro
    return c.json({ message: 'Erro tratado com sucesso' }, 200);
  } catch (error) {
    logger.error(error);
    return c.json({ message: 'Erro interno do servidor' }, 500);
  }
};
