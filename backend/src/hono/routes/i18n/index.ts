import { Hono } from 'hono';
import i18nRoute from './validate_description_translation';

const i18n = new Hono();

i18n.post('/validate-description', i18nRoute);

export default i18n;
