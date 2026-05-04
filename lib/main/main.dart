import 'package:flutter/material.dart';
import 'package:game/main/app_permissions.dart';
import 'package:game/services/permission_service/permission_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final permissionService = PermissionService();
  final appPermissions = AppPermissions(permissionService);
  await appPermissions.requestNecessaryPermissions();
  await appPermissions.checkNecessaryPermissions();
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
      appBar: AppBar(
        title: const Text('Rebeca Game'),
      ),
      body: const Center(
        child: Text('Rebeca Game'),
      ),
    );
  }
}
