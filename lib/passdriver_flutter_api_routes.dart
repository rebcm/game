import 'package:flutter/material.dart';

class PassdriverApiRoutes {
  static const String loginEndpoint = '/api/auth/login';
  static const String logoutEndpoint = '/api/auth/logout';
  static const String userProfileEndpoint = '/api/user/profile';

  static String getEndpoint(String route) {
    switch (route) {
      case 'login':
        return loginEndpoint;
      case 'logout':
        return logoutEndpoint;
      case 'userProfile':
        return userProfileEndpoint;
      default:
        throw ArgumentError('Invalid route');
    }
  }
}

