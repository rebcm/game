import 'package:flutter/material.dart';
import 'package:passdriver/features/test/healthcheck_service.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final HealthcheckService _healthcheckService = HealthcheckService();
  String _status = '';

  Future<void> _checkHealth(String url) async {
    final isHealthy = await _healthcheckService.check(url);
    setState(() {
      _status = isHealthy ? 'Online' : 'Offline';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_status),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _checkHealth('https://example.com/healthcheck'),
              child: Text('Check Health'),
            ),
          ],
        ),
      ),
    );
  }
}
