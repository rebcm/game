import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class SwaggerConfig {
  static const String title = 'Rebeca Game API';
  static const String url = 'https://rebcm.github.io/game/swagger.json';

  static InAppWebViewGroupOptions get options => InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
          javaScriptEnabled: true,
          transparentBackground: true,
        ),
        android: AndroidInAppWebViewOptions(
          useHybridComposition: true,
        ),
      );

  static void show(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SwaggerUI()),
    );
  }
}

class SwaggerUI extends StatefulWidget {
  @override
  _SwaggerUIState createState() => _SwaggerUIState();
}

class _SwaggerUIState extends State<SwaggerUI> {
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
        onWebViewCreated: (controller) => webViewController = controller,
      ),
    );
  }
}
