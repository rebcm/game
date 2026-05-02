import 'package:flutter/material.dart';
import 'package:passdriver/features/accessibility/accessibility_settings.dart';

class AccessibilityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acessibilidade'),
      ),
      body: AccessibilitySettings(),
    );
  }
}
