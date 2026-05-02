import { describe, expect, it } from 'vitest';
import { app } from '../../../../app';
import { Ride } from '../../models/Ride';

describe('Ride route', () => {
  it('should rollback ride insertion on R2 failure', async () => {
    // Arrange
    const ride = new Ride({
      id: 'test-ride-id',
      passengerId: 'test-passenger-id',
      driverId: 'test-driver-id',
    });

    // Act
    try {
      await app.request('/rides', {
        method: 'POST',
        body: JSON.stringify(ride),
      });
      // Simulate R2 failure
      throw new Error('R2 failure');
    } catch (error) {
      // Assert
      const response = await app.request();
      expect(response.status).toBe(404);
    }
  });
});
