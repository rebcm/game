import { Hono } from 'hono';
import { loggingMiddleware } from './routes/logging/logging_middleware';
import { routes } existingRouteFile;

const app = new Hono();
app.use(loggingMiddleware);
app.route('/', routes);

export default app;
