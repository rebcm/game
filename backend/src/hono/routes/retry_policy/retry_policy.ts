import { Context } from 'hono';

const retryPolicy = async (c: Context, errorType: string) => {
  // Lógica para determinar se deve tentar novamente com base no tipo de erro
  if (errorType === 'timeout' || errorType === 'connection_error') {
    // Tentar novamente
    return true;
  }
  // Falhar imediatamente
  return false;
};

const handleFailure = async (c: Context, errorType: string) => {
  if (!await retryPolicy(c, errorType)) {
    // Retornar mensagem de erro para o usuário em português brasileiro
    return c.json({ error: 'Falha ao realizar a operação' }, 500);
  }
};

export default retryPolicy;
