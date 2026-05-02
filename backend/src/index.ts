import { Hono }  from 'hono';
import { handle } from 'hono/cloudflare-workers';

const app = new Hono().basePath('/api');

app.get('/', (c) => c.text('PassDriver Backend'));

export default handle(app);
