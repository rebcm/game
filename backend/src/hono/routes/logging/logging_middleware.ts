import { Context, Next } from 'hono';
import { logger } from '../../utils/logger';

export const loggingMiddleware = async (c: Context, next: Next) => {
  try {
    await next();
    logger.info();
  } catch (e) {
    logger.error();
    throw e;
  }
};
