import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class SwaggerConfig {
  static const String url = 'http://localhost:8080/swagger-ui.html';
  static const String title = 'Rebeca Game API';

  static InAppWebViewGroupOptions get options => InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
          javaScriptEnabled: true,
          transparentBackground: true,
        ),
        android: AndroidInAppWebViewOptions(
          useHybridComposition: true,
        ),
      );
}
