import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/ride_hailing/domain/usecases/get_ride_hailing_data_usecase.dart';

void main() {
  group('GetRideHailingDataUseCase', () {
    test('should return Failure when TimeoutException occurs', () async {
      // Arrange
      final usecase = GetRideHailingDataUseCase();
      // Act
      final result = await usecase.call(params: GetRideHailingDataParams(timeout: Duration(seconds: 1)));
      // Assert
      expect(result, isA<Failure>());
    });
  });
}
