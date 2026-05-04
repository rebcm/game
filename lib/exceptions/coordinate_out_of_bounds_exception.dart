class CoordinateOutOfBoundsException implements Exception {
  final String message;

  CoordinateOutOfBoundsException(this.message);

  @override
  String toString() {
    return 'CoordinateOutOfBoundsException: $message';
  }
}
