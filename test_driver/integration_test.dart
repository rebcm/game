import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  enableFlutterDriverExtension();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game',
      home: Scaffold(
        body: Center(
          child: Text('Game'),
        ),
      ),
    );
  }
}
