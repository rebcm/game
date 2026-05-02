import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:passdriver/features/salvamento/salvamento_repository.dart';

class SalvamentoProvider with ChangeNotifier {
  final SalvamentoRepository _repository;

  SalvamentoProvider(this._repository);

  Future<void> carregarMundo() async {
    await _repository.carregarMundo();
  }
}
