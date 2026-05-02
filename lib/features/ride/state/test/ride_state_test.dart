import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/ride/state/ride_state.dart';

void main() {
  group('RideState', () {
    test('initial status is walking', () {
      final rideState = RideState();
      expect(rideState.status, RideStatus.walking);
    });

    test('update status to driving', () {
      final rideState = RideState();
      rideState.updateStatus(RideStatus.driving);
      expect(rideState.status, RideStatus.driving);
    });

    test('stop ride updates status to stopped', () {
      final rideState = RideState();
      rideState.stopRide();
      expect(rideState.status, RideStatus.stopped);
    });

    test('status is not stuck in walking after stopping', () {
      final rideState = RideState();
      rideState.stopRide();
      expect(rideState.status, isNot(RideStatus.walking));
    });
  });
}
