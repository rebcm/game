addEventListener('fetch', (event) => {
  event.respondWith(handleRequest(event.request));
});

async function handleRequest(request) {
  if (request.method === 'POST' && request.url.pathname === '/api/worlds') {
    const userId = request.headers.get('X-User-Id');
    if (!userId) {
      return new Response('Unauthorized', { status: 401 });
    }
    // TO DO: implement user world count check
    const requestBody = await request.json();
    // TO DO: implement world data validation
    return new Response('Created', { status: 201 });
  }
  return new Response('Not Found', { status: 404 });
}
