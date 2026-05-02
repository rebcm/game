import 'package:flutter/material.dart';
import 'package:rebcm/utils/image_cache.dart';
import 'package:rebcm/widgets/image_widget.dart';

void main() {
  ImageCache.init();
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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ImageWidget(
          url: 'https://example.com/image.jpg',
        ),
      ),
    );
  }
}
