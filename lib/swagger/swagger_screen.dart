import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:game/swagger/swagger_config.dart';

class SwaggerScreen extends StatefulWidget {
  @override
  _SwaggerScreenState createState() => _SwaggerScreenState();
}

class _SwaggerScreenState extends State<SwaggerScreen> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(SwaggerConfig.title),
      ),
      body: InAppWebView(
        key: webViewKey,
        initialUrlRequest: URLRequest(url: Uri.parse(SwaggerConfig.url)),
        initialOptions: SwaggerConfig.options,
        onWebViewCreated: (controller) {
          webViewController = controller;
        },
      ),
    );
  }
}
