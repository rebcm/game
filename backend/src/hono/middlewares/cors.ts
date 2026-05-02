import { Context, Next } from 'hono'; 
import { cors } from 'hono/cors';

export const corsConfig = cors({
  origin: ['http://localhost:7357', 'https://passdriver.com.br'],
  allowHeaders: ['Content-Type', 'Authorization'],
  allowMethods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  exposeHeaders: ['Content-Length', 'X-Kuma-Revision'],
  maxAge: 600,
  credentials: true,
});

export const corsMiddleware = async (c: Context, next: Next) => {
  return corsConfig(c, next);
};
