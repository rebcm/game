import { Hono } from 'hono';
import { test } from './test';

const app = new Hono();

app.get('/api/test', test);

export default app;
