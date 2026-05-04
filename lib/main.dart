import 'package:flutter/material.dart';
import 'package:game/services/tracking/package_tracker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PackageTracker _packageTracker = PackageTracker();

  void _handleInput(int packageId) {
    _packageTracker.addPackageId(packageId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Package Tracking Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _handleInput(1),
          child: Text('Send Package'),
        ),
      ),
    );
  }
}
