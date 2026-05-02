import 'package:flutter/material.dart';
import 'package:passdriver/features/mundos_do_usuario/domain/mundos_do_usuario_usecase.dart';

class MundosDoUsuarioViewModel with ChangeNotifier {
  final MundosDoUsuarioUseCase _useCase;

  MundosDoUsuarioViewModel(this._useCase);

  Future<void> getMundosDoUsuario() async {
    final mundos = await _useCase.getMundosDoUsuario();
    // Update the UI with the mundos
  }
}
