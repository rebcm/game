import { env } from 'hono/adapter';

const jwtConfig = {
  secret: env.JWT_SECRET,
};

export default jwtConfig;
