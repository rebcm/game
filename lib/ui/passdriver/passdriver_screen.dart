import 'package:flutter/material.dart';
import 'package:game/services/content_integration/content_integration_service.dart';

class PassdriverScreen extends StatefulWidget {
  @override
  _PassdriverScreenState createState() => _PassdriverScreenState();
}

class _PassdriverScreenState extends State<PassdriverScreen> {
  final ContentIntegrationService _contentIntegrationService = ContentIntegrationService();

  @override
  void initState() {
    super.initState();
    _contentIntegrationService.loadTips();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Passdriver'),
      ),
      body: Center(
        child: Text('Passdriver Screen'),
      ),
    );
  }
}
