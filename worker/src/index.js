// =====================================================================
// Construção Criativa 3D — Multiplayer Worker
//
// Cloudflare Worker + Durable Object "Room": cada room é uma WebSocket
// hub. Mensagens recebidas de um socket são RE-broadcast pra todos os
// outros sockets da mesma room. State é mínimo (lista de sessions ativas).
//
// Uso pelo cliente:
//   const ws = new WebSocket(`wss://<worker-url>/ws?room=NAME`);
//   ws.onmessage = (ev) => { ...processa msg de outros players... };
//   ws.send(JSON.stringify({ tipo:'pos', name, x, y, z, rot }));
//
// Limites do free tier (Workers Paid Plan recomendado pra produção):
// - 1M req/dia, 30s CPU/req, 1000 simultâneos por DO.
// - Durable Objects também precisam de paid plan ($5/mês) atualmente.
// =====================================================================

export class Room {
  constructor(state, env) {
    this.state = state;
    this.env = env;
    this.sessions = []; // [{ ws, id }]
  }

  async fetch(request) {
    const url = new URL(request.url);
    if (url.pathname === '/ws') {
      const upgradeHeader = request.headers.get('Upgrade');
      if (upgradeHeader !== 'websocket') {
        return new Response('Expected WebSocket', { status: 426 });
      }
      const pair = new WebSocketPair();
      const [client, server] = Object.values(pair);
      this._handleSession(server);
      return new Response(null, { status: 101, webSocket: client });
    }
    if (url.pathname === '/health') {
      return new Response(JSON.stringify({ sessions: this.sessions.length }), {
        headers: { 'content-type': 'application/json' },
      });
    }
    return new Response('Construção Criativa Multiplayer Worker', { status: 200 });
  }

  _handleSession(ws) {
    ws.accept();
    const session = { ws, id: crypto.randomUUID() };
    this.sessions.push(session);

    ws.addEventListener('message', (ev) => {
      // Broadcast pra todos exceto remetente. Mensagem opaca pro server
      // (cliente faz JSON parse). Skip sessions com ws fechado.
      const msg = ev.data;
      const ativos = [];
      for (const s of this.sessions) {
        if (s === session) { ativos.push(s); continue; }
        try {
          if (s.ws.readyState <= 1) { // CONNECTING ou OPEN
            s.ws.send(msg);
            ativos.push(s);
          }
        } catch (_) { /* drop session */ }
      }
      this.sessions = ativos;
    });

    const onClose = () => {
      this.sessions = this.sessions.filter(s => s !== session);
    };
    ws.addEventListener('close', onClose);
    ws.addEventListener('error', onClose);
  }
}

export default {
  async fetch(request, env) {
    const url = new URL(request.url);
    // CORS pré-flight (browsers strict podem mandar)
    if (request.method === 'OPTIONS') {
      return new Response(null, {
        status: 204,
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
          'Access-Control-Allow-Headers': 'Content-Type, Upgrade',
        },
      });
    }
    if (url.pathname === '/' || url.pathname === '') {
      return new Response('Construção Criativa MP Worker — use /ws?room=NAME', {
        headers: { 'content-type': 'text/plain' },
      });
    }
    const room = (url.searchParams.get('room') || 'global').slice(0, 64);
    const id = env.ROOMS.idFromName(room);
    const obj = env.ROOMS.get(id);
    return obj.fetch(request);
  },
};
