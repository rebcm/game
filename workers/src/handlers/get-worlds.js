import { getUserWorlds } from '../services/d1.js';

export async function handleGetWorlds(request) {
  const userId = request.headers.get('X-User-ID');
  if (!userId) {
    return new Response(JSON.stringify({ error: 'User ID is required' }), {
      status: 401,
      headers: { 'Content-Type': 'application/json' },
    });
  }

  try {
    const worlds = await getUserWorlds(userId);
    return new Response(JSON.stringify(worlds), {
      status: 200,
      headers: { 'Content-Type': 'application/json' },
    });
  } catch (error) {
    return new Response(JSON.stringify({ error: 'Failed to fetch worlds' }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' },
    });
  }
}
