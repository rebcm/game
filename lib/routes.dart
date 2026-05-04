import 'package:flutter/material.dart';
import 'package:game/pages/swagger_page.dart';

class AppRoutes {
  static const String swaggerRoute = '/swagger';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      swaggerRoute: (context) => SwaggerPage(),
    };
  }
}
