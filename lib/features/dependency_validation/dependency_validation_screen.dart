import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:passdriver/dependency_validation/dependency_validation_provider.dart';

class DependencyValidationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dependencyValidationProvider = Provider.of<DependencyValidation>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Validação de Dependência'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Validar Dependência Hive'),
          onPressed: () async {
            await dependencyValidationProvider.validateHive();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Dependência Hive validada com sucesso!')),
            );
          },
        ),
      ),
    );
  }
}
