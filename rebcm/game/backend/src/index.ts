import { Hono } from 'hono';
import { worlds } from './worlds';
import { auth } from './auth';
import { storage } from './storage';

const app = new Hono();

app.route('/worlds', worlds);
app.route('/auth', auth);
app.route('/storage', storage);

export default app;
