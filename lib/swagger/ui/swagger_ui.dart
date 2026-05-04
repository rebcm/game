import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class SwaggerUI extends StatefulWidget {
  @override
  _SwaggerUIState createState() => _SwaggerUIState();
}

class _SwaggerUIState extends State<SwaggerUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Swagger UI'),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse('http://localhost:8000/swagger')),
      ),
    );
  }
}
