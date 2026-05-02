import { Hono } from 'hono';
import { localizacaoRoute } from './localizacao/localizacao_route';
import game from './routes/game';

const app = new Hono();

app.route('/game', game);

export default app;
import rebeccaCharacterRoute from './routes/rebecca/rebecca_character';

app.route('/api', rebeccaCharacterRoute);
