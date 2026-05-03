class PassdriverAuthenticationException implements Exception {
  final String message;

  PassdriverAuthenticationException(this.message);

  @override
  String toString() {
    return 'PassdriverAuthenticationException: $message';
  }
}

class PassdriverInfrastructureException implements Exception {
  final String message;

  PassdriverInfrastructureException(this.message);

  @override
  String toString() {
    return 'PassdriverInfrastructureException: $message';
  }
}

class PassdriverPayloadException implements Exception {
  final String message;

  PassdriverPayloadException(this.message);

  @override
  String toString() {
    return 'PassdriverPayloadException: $message';
  }
}
