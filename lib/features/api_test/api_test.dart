import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiTestPage extends StatefulWidget {
  @override
  _ApiTestPageState createState() => _ApiTestPageState();
}

class _ApiTestPageState extends State<ApiTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Test'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final response = await http.get(Uri.parse('https://example.com/api/test'));
            if (response.statusCode == 200) {
              print('Success');
            } else {
              print('Failed');
            }
          },
          child: Text('Test API'),
        ),
      ),
    );
  }
}
