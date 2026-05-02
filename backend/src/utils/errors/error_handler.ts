export function errorHandler(c, error) {
  const errorCode = error.status || 507;
  const errorMessage = error.message || 'Erro interno';
  return c.json({ error: errorMessage }, errorCode);
}
