import { Hono } from 'hono';
import selfHealingTest from './self_healing_test/self_healing_test';

const app = new Hono();

app.route('/self_healing_test', selfHealingTest);

export default app;
