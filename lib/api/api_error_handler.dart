import 'package:http/http.dart';

class ApiErrorHandler {
  static String handleError(Response response) {
    switch (response.statusCode) {
      case 401:
        return 'Unauthorized';
      case 404:
        return 'Not Found';
      case 500:
        return 'Internal Server Error';
      default:
        return 'Unknown Error';
    }
  }
}
