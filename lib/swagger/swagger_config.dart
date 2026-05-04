import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class SwaggerConfig {
  static const String swaggerUrl = 'https://your-swagger-url.com/v2/api-docs';
  static const String swaggerUiUrl = 'assets/swagger-ui/index.html';

  static InAppWebViewGroupOptions getWebViewOptions() {
    return InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        javaScriptEnabled: true,
        transparentBackground: true,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
    );
  }
}
