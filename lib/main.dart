import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/config/deadzone_config.dart';
import 'package:rebcm/screens/settings/deadzone_settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final deadzoneConfig = DeadzoneConfig();
  await deadzoneConfig.loadDeadzoneThreshold();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => deadzoneConfig),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca\'s World',
      home: MyHomePage(),
      routes: {
        '/deadzoneSettings': (context) => DeadzoneSettingsScreen(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rebeca\'s World'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/deadzoneSettings');
          },
          child: Text('Deadzone Settings'),
        ),
      ),
    );
  }
}
