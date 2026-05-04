import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionBinding extends StatefulWidget {
  @override
  _PermissionBindingState createState() => _PermissionBindingState();
}

class _PermissionBindingState extends State<PermissionBinding> {
  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  Future<void> _requestPermission() async {
    await Permission.audio.request();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Permission Test'),
        ),
      ),
    );
  }
}
