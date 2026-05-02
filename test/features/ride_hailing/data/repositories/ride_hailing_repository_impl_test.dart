import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/ride_hailing/data/repositories/ride_hailing_repository_impl.dart';

void main() {
  group('RideHailingRepositoryImpl', () {
    test('should return TimeoutException when request timeout occurs', () async {
      // Arrange
      final repository = RideHailingRepositoryImpl();
      // Act
      final result = await repository.getRideHailingData(timeout: Duration(seconds: 1));
      // Assert
      expect(result, isA<TimeoutException>());
    });
  });
}
