import 'package:flutter_test/flutter_test.dart';
import 'package:game/passdriver_flutter_api_routes.dart';

void main() {
  group('PassdriverApiRoutes', () {
    test('getEndpoint returns correct login endpoint', () {
      expect(PassdriverApiRoutes.getEndpoint('login'), '/api/auth/login');
    });

    test('getEndpoint returns correct logout endpoint', () {
      expect(PassdriverApiRoutes.getEndpoint('logout'), '/api/auth/logout');
    });

    test('getEndpoint returns correct user profile endpoint', () {
      expect(PassdriverApiRoutes.getEndpoint('userProfile'), '/api/user/profile');
    });

    test('getEndpoint throws ArgumentError for invalid route', () {
      expect(() => PassdriverApiRoutes.getEndpoint('invalid'), throwsArgumentError);
    });
  });
}

