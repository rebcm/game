import { Hono } from 'hono';
import createWorld from './routes/worlds/create';

const app = new Hono();

app.post('/api/worlds', createWorld);

export default app;
