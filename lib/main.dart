import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/services/preferences_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferencesService = PreferencesService();

  runApp(
    MultiProvider(
      providers: [
        Provider<PreferencesService>(create: (_) => preferencesService),
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
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _volume = 1.0;

  @override
  void initState() {
    super.initState();
    _loadVolume();
  }

  Future<void> _loadVolume() async {
    final preferencesService = Provider.of<PreferencesService>(context, listen: false);
    final volume = await preferencesService.getVolume();
    setState(() {
      _volume = volume;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Slider(
          value: _volume,
          onChanged: (value) async {
            final preferencesService = Provider.of<PreferencesService>(context, listen: false);
            await preferencesService.setVolume(value);
            setState(() {
              _volume = value;
            });
          },
          min: 0.0,
          max: 1.0,
        ),
      ),
    );
  }
}
