import { test } from '@jest/globals';
import { cleanup } from './cleanup';

test('cleanup', async () => {
  await cleanup();
});
