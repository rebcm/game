import 'package:flutter/material.dart';
import 'package:game/services/upload_service/upload_retry_logic.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UploadExample(),
    );
  }
}

class UploadExample extends StatefulWidget {
  @override
  _UploadExampleState createState() => _UploadExampleState();
}

class _UploadExampleState extends State<UploadExample> {
  final Dio _dio = Dio();
  final UploadRetryLogic _uploadRetryLogic = UploadRetryLogic(Dio());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await _uploadRetryLogic.uploadWithRetry('test_file.txt', '/upload');
          },
          child: Text('Upload File'),
        ),
      ),
    );
  }
}
