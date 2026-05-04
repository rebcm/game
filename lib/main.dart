import 'package:flutter/material.dart';
import 'package:game/utils/ui_utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Overflow Protection Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UIUtils.protectOverflow('This is a very long text that should be protected from overflow'),
              const SizedBox(height: 20),
              UIUtils.makeScrollableText('This is another long text that should be scrollable'),
            ],
          ),
        ),
      ),
    );
  }
}
