import { Hono } from 'hono';
import { errorHandlingMiddleware } from './error_handling/error_handling_middleware';

const app = new Hono();
app.use('*', errorHandlingMiddleware);

// Existing route patterns...

