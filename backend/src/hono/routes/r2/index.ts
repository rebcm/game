import { Hono } from 'hono';
import r2 from './r2_list_chunks';

const app = new Hono();

app.get('/r2/chunks', r2);

export default app;
