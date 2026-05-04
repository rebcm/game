class CloudflareR2Config {
  static String get accountId => const String.fromEnvironment('CLOUDFLARE_ACCOUNT_ID');
  static String get accessKeyId => const String.fromEnvironment('CLOUDFLARE_ACCESS_KEY_ID');
  static String get secretAccessKey => const String.fromEnvironment('CLOUDFLARE_SECRET_ACCESS_KEY');
  static String get bucket => const String.fromEnvironment('CLOUDFLARE_BUCKET');
}
