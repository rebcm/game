class InvalidCoordinateException implements Exception {
  final String message;

  InvalidCoordinateException(this.message);

  @override
  String toString() {
    return 'InvalidCoordinateException: $message';
  }
}
