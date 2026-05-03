-- Criação da tabela de usuários
CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY,
    username TEXT NOT NULL,
    email TEXT NOT NULL,
    created_at INTEGER NOT NULL,
    updated_at INTEGER NOT NULL
);

-- Criação da tabela de blocos
CREATE TABLE IF NOT EXISTS blocks (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    block_type TEXT NOT NULL,
    position_x INTEGER NOT NULL,
    position_y INTEGER NOT NULL,
    position_z INTEGER NOT NULL,
    created_at INTEGER NOT NULL,
    updated_at INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Criação de índices para melhorar a performance das consultas
CREATE INDEX IF NOT EXISTS idx_blocks_user_id ON blocks(user_id);
CREATE INDEX IF NOT EXISTS idx_blocks_position ON blocks(position_x, position_y, position_z);
