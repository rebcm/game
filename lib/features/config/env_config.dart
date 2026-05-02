class EnvConfig {
  static const String apiUrl = String.fromEnvironment('API_URL');
  static const String environment = String.fromEnvironment('ENVIRONMENT');
}

  static bool get isDevelopment => environment == 'development';
  static bool get isProduction => environment == 'production';
}
