import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompressaoProvider with ChangeNotifier {
  double _bitrateMinimo = 128; // kbps
  double get bitrateMinimo => _bitrateMinimo;

  double _tamanhoBinarioOriginal = 0; // bytes
  double get tamanhoBinarioOriginal => _tamanhoBinarioOriginal;

  double _tamanhoBinarioComprimido = 0; // bytes
  double get tamanhoBinarioComprimido => _tamanhoBinarioComprimido;

  double get taxaCompressao => _tamanhoBinarioOriginal > 0 ? (_tamanhoBinarioComprimido / _tamanhoBinarioOriginal) * 100 : 0;

  void atualizaBitrateMinimo(double novoBitrate) {
    _bitrateMinimo = novoBitrate;
    notifyListeners();
  }

  void atualizaTamanhoBinarioOriginal(double tamanho) {
    _tamanhoBinarioOriginal = tamanho;
    notifyListeners();
  }

  void atualizaTamanhoBinarioComprimido(double tamanho) {
    _tamanhoBinarioComprimido = tamanho;
    notifyListeners();
  }
}
