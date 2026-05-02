import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class DocumentationI18n extends StatefulWidget {
  @override
  _DocumentationI18nState createState() => _DocumentationI18nState();
}

class _DocumentationI18nState extends State<DocumentationI18n> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, 'documentation.title')),
      ),
      body: Center(
        child: Text(FlutterI18n.translate(context, 'documentation.content')),
      ),
    );
  }
}
