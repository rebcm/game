import 'package:flutter/material.dart';
import 'package:game/services/permission/permission_service.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final permissionService = PermissionService();
  final storagePermission = await permissionService.requestPermission(Permission.storage);
  if (!storagePermission) {
    // Handle permission denied
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca Game',
      home: Scaffold(
        body: Center(
          child: Text('Rebeca Game'),
        ),
      ),
    );
  }
}
