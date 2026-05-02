import { describe, expect, it } from 'vitest';
import { app } from '../../../../src/hono/app';
import { D1Database } from '@cloudflare/workers-types';

describe('Ride Route', () => {
  it('should rollback ride insertion on R2 failure', async () => {
    // Arrange
    const db = (await app.request('/db')) as D1Database;
    const ride = {
      id: 'test-ride-id',
      passengerId: 'test-passenger-id',
      driverId: 'test-driver-id',
    };

    // Act
    try {
      await app.request('/rides', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(ride),
      });
      // Simulate R2 failure
      throw new Error('R2 failure');
    } catch (e) {
      // Assert
      const result = await db
        .prepare('SELECT * FROM rides WHERE id = ?')
        .bind(ride.id)
        .run();
      expect(result.results.length).toBe(0);
    }
  });
});
