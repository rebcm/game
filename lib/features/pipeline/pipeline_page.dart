import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PipelinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pipeline de CI/CD'),
      ),
      body: Center(
        child: Text('Pipeline de CI/CD emexecução'),
      ),
    );
  }
}
