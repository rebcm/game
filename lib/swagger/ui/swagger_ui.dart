import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:game/swagger/swagger_config.dart';

class SwaggerUI extends StatefulWidget {
  @override
  _SwaggerUIState createState() => _SwaggerUIState();
}

class _SwaggerUIState extends State<SwaggerUI> {
  late InAppWebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Swagger UI'),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(SwaggerConfig.swaggerUiUrl)),
        initialOptions: SwaggerConfig.getWebViewOptions(),
        onWebViewCreated: (InAppWebViewController controller) {
          _webViewController = controller;
        },
        onLoadStop: (controller, url) async {
          if (url != null) {
            await controller.evaluateJavascript(source: '''
              const swaggerUi = SwaggerUIBundle({
                url: '${SwaggerConfig.swaggerUrl}',
                dom_id: '#swagger-ui',
                presets: [
                  SwaggerUIBundle.presets.apis,
                  SwaggerUIBundle.SwaggerUIStandalonePreset
                ],
                layout: 'StandaloneLayout'
              });
            ''');
          }
        },
      ),
    );
  }
}
