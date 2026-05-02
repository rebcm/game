import 'package:flutter/material.dart';
import 'package:passdriver/features/mundos/models/mundo_model.dart';

class ValidacaoMundo with ChangeNotifier {
  String? _mensagemErro;

  String? get mensagemErro => _mensagemErro;

  bool validarMundo(MundoModel mundo) {
    if (mundo.nome.isEmpty) {
      _mensagemErro = 'O nome do mundo é obrigatório';
      notifyListeners();
      return false;
    }
    _mensagemErro = null;
    notifyListeners();
    return true;
  }
}
