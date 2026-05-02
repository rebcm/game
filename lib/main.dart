import 'package:flutter/material.dart';
import 'package:rebcm/services/error_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca\'s Creative Game',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            try {
              // Simulate an error
              throw TimeoutException('Test timeout');
            } catch (e) {
              ErrorHandler.handleError('MyHomePage', e);
            }
          },
          child: Text('Test Error'),
        ),
      ),
    );
  }
}
