import { Hono } from 'hono';
import game from './routes/game';

const app = new Hono();

app.route('/game', game);

export default app;
