class ErrorHandler {
  static void handleError(Exception e) {
    if (e.toString().contains('Invalid or insufficient token')) {
      print('Error: Invalid or insufficient token. Deployment stopped.');
      // Stop deployment process
      exit(1);
    } else {
      print('An error occurred: $e');
    }
  }
}
