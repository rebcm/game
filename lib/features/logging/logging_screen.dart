import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'logging_provider.dart';

class LoggingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loggingProvider = context.watch<LoggingProvider>();
    return Scaffold(
      appBar: AppBar(title: Text('Logs')),
      body: ListView(
        children: [
          ListTile(title: Text('Log Info'), trailing: IconButton(icon: Icon(Icons.info), onPressed: () => loggingProvider.logInfo('Info log'))),
          ListTile(title: Text('Log Error'), trailing: IconButton(icon: Icon(Icons.error), onPressed: () => loggingProvider.logError('Error log', Exception('Test error')))),
        ],
      ),
    );
  }
}
