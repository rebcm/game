import 'package:flutter/material.dart';
import 'package:passdriver/features/mundos_do_usuario/domain/mundos_do_usuario_usecase.dart';

class MundosDoUsuarioViewModel with ChangeNotifier {
  final MundosDoUsuarioUsecase _usecase;

  List<MundosDoUsuario> _mundosDoUsuario = [];
  bool _isLoading = false;

  MundosDoUsuarioViewModel(this._usecase);

  List<MundosDoUsuario> get mundosDoUsuario => _mundosDoUsuario;
  bool get isLoading => _isLoading;

  Future<void> loadMundosDoUsuario() async {
    _isLoading = true;
    notifyListeners();

    final result = await _usecase();

    result.fold((error) {
      // handle error
    }, (mundos) {
      _mundosDoUsuario = mundos;
    });

    _isLoading = false;
    notifyListeners();
  }
}
