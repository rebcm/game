import 'package:flutter/material.dart';
import 'package:game/services/upload/upload_service.dart';
import 'dart:io';

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
  void _uploadFile() async {
    var file = File('test_file.txt');
    await file.writeAsString('Test content');
    var uploadService = UploadService();
    await uploadService.retryUpload(file);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _uploadFile,
          child: Text('Upload File'),
        ),
      ),
    );
  }
}
