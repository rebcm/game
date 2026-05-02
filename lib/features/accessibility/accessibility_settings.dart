import 'package:flutter/material.dart';

class AccessibilitySettings extends StatefulWidget {
  @override
  _AccessibilitySettingsState createState() => _AccessibilitySettingsState();
}

class _AccessibilitySettingsState extends State<AccessibilitySettings> {
  bool _highContrast = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SwitchListTile(
          title: Text('Alto Contraste'),
          value: _highContrast,
          onChanged: (value) {
            setState(() {
              _highContrast = value;
            });
          },
        ),
      ],
    );
  }
}
