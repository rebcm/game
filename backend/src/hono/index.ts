import { Router } from 'hono';
import { audioRouter } from './routes/audio/audio_route';

const app = new Router();

app.use('/audio', audioRouter);

export { app };
