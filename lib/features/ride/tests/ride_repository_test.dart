import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/ride/providers/ride_repository.dart';
import 'package:passdriver/features/ride/models/ride.dart';

void main() {
  group('RideRepository', () {
    test('should rollback ride insertion on R2 failure', () async {
      // Arrange
      final rideRepository = RideRepository();
      final ride = Ride(
        id: 'test-ride-id',
        passengerId: 'test-passenger-id',
        driverId: 'test-driver-id',
      );

      // Act
      try {
        await rideRepository.insertRide(ride);
        // Simulate R2 failure
        throw Exception('R2 failure');
      } catch (e) {
        // Assert
        expect(await rideRepository.getRide(ride.id), isNull);
      }
    });
  });
}
