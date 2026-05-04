import 'package:flutter/material.dart';
import 'package:game/logging/logger.dart';

class LogScreen extends StatefulWidget {
  @override
  _LogScreenState createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  List<String> _logs = [];

  @override
  void initState() {
    super.initState();
    Logger.log('Log screen initialized');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logs'),
      ),
      body: ListView.builder(
        itemCount: _logs.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_logs[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _logs.add(Logger.log('New log entry'));
          });
        },
        tooltip: 'Add Log',
        child: Icon(Icons.add),
      ),
    );
  }
}
