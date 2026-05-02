import 'package:flutter/material.dart';
import 'package:passdriver/features/world_creation/world_creation_provider.dart';

class WorldCreationScreen extends StatefulWidget {
  @override
  _WorldCreationScreenState createState() => _WorldCreationScreenState();
}

class _WorldCreationScreenState extends State<WorldCreationScreen> {
  final _worldNameController = TextEditingController();
  final _worldCreationProvider = WorldCreationProvider(ApiProvider());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Novo Mundo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _worldNameController,
              decoration: InputDecoration(
                labelText: 'Nome do Mundo',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _worldCreationProvider.createWorld(_worldNameController.text);
                Navigator.pop(context);
              },
              child: Text('Criar Mundo'),
            ),
          ],
        ),
      ),
    );
  }
}
