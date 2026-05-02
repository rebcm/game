import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/ui/error_handler.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ErrorHandler()),
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
      title: 'Rebcm Game',
      builder: (context, child) {
        final errorHandler = context.watch<ErrorHandler>();
        errorHandler.showErrorDialog(context);
        return child!;
      },
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Your game UI here
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rebcm Game'),
      ),
      body: const Center(
        child: Text('Game Content'),
      ),
    );
  }
}
