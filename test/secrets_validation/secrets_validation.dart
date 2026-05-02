class SecretsValidator {
  static bool validateSecrets(Map<String, String> secrets) {
    return secrets['SECRET1'] != null && secrets['SECRET2'] != null;
  }
}
