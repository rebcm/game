import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_app/features/persistence/persistence_manager.dart';
import 'package:your_app/features/rebecca_character/providers/rebecca_character_provider.dart';
import 'package:your_app/features/world_api/models/world_payload_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final persistenceManager = PersistenceManager();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => persistenceManager),
        ChangeNotifierProvider(create: (_) => RebeccaCharacterProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Construção Criativa',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final persistenceManager = context.read<PersistenceManager>();
    final data = await persistenceManager.loadData();
    if (data != null) {
      // Load game state from data
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Construção Criativa'),
      ),
    );
  }
}
