addEventListener('fetch', (event) => {
  event.respondWith(handleRequest(event.request));
});

async function handleRequest(request) {
  const envVars = {
    VARIABLE_NAME: VARIABLE_NAME,
    // Add more environment variables and secrets here
  };

  for (const [key, value] of Object.entries(envVars)) {
    if (!value) {
      return new Response(`Environment variable or secret '${key}' is missing or empty`, { status: 500 });
    }
  }

  return new Response('All environment variables and secrets are present', { status: 200 });
}
