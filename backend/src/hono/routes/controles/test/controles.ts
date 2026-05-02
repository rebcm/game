import { D1Database } from '@cloudflare/workers-types';

interface Controles {
  validarCritériosDeAceitação(db: D1Database): Promise<boolean>;
}

const controles: Controles = {
  validarCritériosDeAceitação: async (db: D1Database) => {
    const { results } = await db.prepare('SELECT * FROM controles').all();
    return results.length > 0;
  },
};

export { controles };
