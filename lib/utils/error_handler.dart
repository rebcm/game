class ErrorHandler {
  static void handleError(Exception e) {
    if (e.toString().contains('Invalid or insufficient token')) {
      print('Error: Invalid or insufficient token. Deployment stopped.');
      // Stop deployment logic here
    } else {
      print('An error occurred: $e');
    }
  }
}
