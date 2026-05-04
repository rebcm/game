class EnvironmentConfig {
  static const String environment = String.fromEnvironment('ENVIRONMENT');
  static bool get isPreview => environment == 'preview';
}
