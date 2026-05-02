import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/ride/providers/ride_provider.dart';

void main() {
  test('Ride provider updates speed', () {
    final rideProvider = RideProvider();
    rideProvider.updateSpeed(50);
    expect(rideProvider.speed, 50);
  });
}
