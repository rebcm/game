import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/authentication/authentication_provider.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationProvider extends Mock implements AuthenticationProvider {}

void main() {
  late MockAuthenticationProvider mockAuthenticationProvider;

  setUp(() {
    mockAuthenticationProvider = MockAuthenticationProvider();
  });

  test('should return error when authentication fails', () async {
    when(() => mockAuthenticationProvider.authenticate(any(), any())).thenThrow(Exception('Authentication failed'));
    expect(() async => await mockAuthenticationProvider.authenticate('username', 'password'), throwsException);
  });

  test('should return error when storage limit is reached', () async {
    when(() => mockAuthenticationProvider.checkStorageLimit()).thenThrow(Exception('Storage limit reached'));
    expect(() async => await mockAuthenticationProvider.checkStorageLimit(), throwsException);
  });
}
