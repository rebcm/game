import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/configuracoes/volume/volume_provider.dart';
import 'package:rebcm/widgets/configuracoes/volume_settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final volumeProvider = VolumeProvider();
  await volumeProvider.loadVolumeConfig();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => volumeProvider),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca\'s World',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Rebeca\'s World'),
        ),
        body: const VolumeSettings(),
      ),
    );
  }
}
