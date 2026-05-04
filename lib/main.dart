import 'package:flutter/material.dart';
import 'package:game/features/feedback_form/feedback_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FeedbackForm(),
    );
  }
}
