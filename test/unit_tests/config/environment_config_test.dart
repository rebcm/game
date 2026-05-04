import 'package:flutter_test/flutter_test.dart';
import 'package:game/config/environment_config.dart';

void main() {
  group('EnvironmentConfig', () {
    test('init sets the environment', () {
      EnvironmentConfig.init(environment: Environment.staging);
      expect(EnvironmentConfig.environment, Environment.staging);
    });

    test('isStaging returns true for staging environment', () {
      EnvironmentConfig.init(environment: Environment.staging);
      expect(EnvironmentConfig.isStaging, true);
    });

    test('isProduction returns true for production environment', () {
      EnvironmentConfig.init(environment: Environment.production);
      expect(EnvironmentConfig.isProduction, true);
    });
  });
}
