import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:your_app_name/features/salvamento/repositories/salvamento_repository.dart';

class SalvamentoStore with ChangeNotifier {
  final SalvamentoRepository _salvamentoRepository;
  String _mundoSalvo = '';

  SalvamentoStore(this._salvamentoRepository);

  String get mundoSalvo => _mundoSalvo;

  Future<void> salvarMundo(String mundo) async {
    await _salvamentoRepository.salvarMundo(mundo);
    _mundoSalvo = mundo;
    notifyListeners();
  }

  Future<void> carregarMundo() async {
    final mundo = await _salvamentoRepository.carregarMundo();
    _mundoSalvo = mundo;
    notifyListeners();
  }
}
