class ApiHeaders {
  static Map<String, String> getAuthorizationHeader(String token) {
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  static Map<String, String> getContentTypeHeader() {
    return {
      'Content-Type': 'application/json',
    };
  }
}
