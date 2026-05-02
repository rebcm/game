import { Context } from 'hono';
import { HTTPException } from 'hono/http-exception';

const errorHandlingMatrix = {
  // Implement the error handling matrix here
  'TimeoutError': true,
  'SocketError': true,
  'ServerError': false,
};

export function shouldRetry(error: Error): boolean {
  return errorHandlingMatrix[error.name] ?? false;
}

export async function errorHandlingMiddleware(c: Context, next: () => Promise<void>) {
  try {
    await next();
  } catch (error: any) {
    if (error instanceof HTTPException) {
      throw error;
    }

    if (shouldRetry(error)) {
      // Implement retry logic here
    } else {
      throw new HTTPException(500, { message: 'Erro interno do servidor' });
    }
  }
}
