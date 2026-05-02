class ErrorHandlingMatrix {
  final Map<Type, bool> _matrix = {
    // Implement the error handling matrix here
    TimeoutException: true,
    SocketException: true,
    ServerException: false,
  };

  bool shouldRetry(Exception exception) => _matrix[exception.runtimeType] ?? false;
}
