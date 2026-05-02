import 'package:flutter/material.dart';
import 'package:passdriver/features/dependencies_validation/services/hive_service.dart';

class DependenciesValidation extends StatefulWidget {
  @override
  _DependenciesValidationState createState() => _DependenciesValidationState();
}

class _DependenciesValidationState extends State<DependenciesValidation> {
  final HiveService _hiveService = HiveService();

  @override
  void initState() {
    super.initState();
    _hiveService.initHive();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Validação de Dependências'),
      ),
      body: Center(
        child: Text('Validação de Dependências'),
      ),
    );
  }
}
