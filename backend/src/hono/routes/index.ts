import { Hono } from 'hono';
import uploadChunksRoute from './upload/upload_chunks';

const app = new Hono();

app.route('/upload', uploadChunksRoute);

export default app;
