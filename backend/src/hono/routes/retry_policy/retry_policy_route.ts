import { Hono } from 'hono';\n
const retryPolicyRoute = new Hono();\n
retryPolicyRoute.get('/retry-policy', async (c) => {
  const errorType = c.req.query('errorType');
  let policy;

  switch (errorType) {
    case 'network_error':
      policy = { policy: 'retry', maxAttempts: 3 };
      break;
    case 'server_error':
      policy = { policy: 'failFast', maxAttempts: 1 };
      break;
    default:
      policy = { policy: 'retry', maxAttempts: 2 };
  }

  return c.json(policy);
});
