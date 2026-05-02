export default {
  async fetch(request: Request, env: any, ctx: any) {
    return new Response('Deploy to Cloudflare Pages');
  }
}
