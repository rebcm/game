import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/ride_hailing/providers/ride_hailing_provider.dart';

void main() {
  test('RideHailingProvider should handle state transitions', () async {
    final provider = RideHailingProvider();
    await provider.fetchRideStatus();
    expect(provider.rideStatus, isNotNull);
  });

  test('RideHailingProvider should handle UI interruptions', () async {
    final provider = RideHailingProvider();
    await provider.fetchRideStatus();
    await provider.cancelRide();
    expect(provider.rideStatus, isNull);
  });
}
