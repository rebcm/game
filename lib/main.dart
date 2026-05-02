import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StateService()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca Game',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final stateService = Provider.of<StateService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Rebeca Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                stateService.addState(StateModel(id: '1', data: 'Test Data'));
              },
              child: Text('Add State'),
            ),
            ElevatedButton(
              onPressed: () {
                stateService.removeState('1');
              },
              child: Text('Remove State'),
            ),
            ElevatedButton(
              onPressed: () {
                stateService.updateState(StateModel(id: '1', data: 'Updated Data'));
              },
              child: Text('Update State'),
            ),
          ],
        ),
      ),
    );
  }
}
