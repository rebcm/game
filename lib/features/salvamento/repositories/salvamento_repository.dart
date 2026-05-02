import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_app_name/features/salvamento/services/salvamento_service.dart';

abstract class SalvamentoRepository {
  Future<void> salvarMundo(String mundo);
  Future<String> carregarMundo();
}

class SalvamentoRepositoryImpl extends SalvamentoRepository {
  final SalvamentoService _salvamentoService;

  SalvamentoRepositoryImpl(this._salvamentoService);

  @override
  Future<void> salvarMundo(String mundo) async {
    await _salvamentoService.salvarMundo(mundo);
  }

  @override
  Future<String> carregarMundo() async {
    return await _salvamentoService.carregarMundo();
  }
}
