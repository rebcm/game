import { Hono } from 'hono'; 
import { corsMiddleware } from './middlewares/cors';

const app = new Hono();
app.use('*', corsMiddleware); 
// existing routes here...
