import 'package:flutter/material.dart';

class DicasService with ChangeNotifier {
  int _tempoLeitura = 0;
  int _cliques = 0;
  int _totalJogadores = 0;
  List<String> _feedback = [];

  int get tempoLeitura => _tempoLeitura;
  double get taxaClique => _totalJogadores > 0 ? (_cliques / _totalJogadores) * 100 : 0;
  double get feedbackPositivo => _feedback.length > 0 ? (_feedback.where((f) => f == 'útil' || f == 'muito útil').length / _feedback.length) * 100 : 0;

  void registrarTempoLeitura(int tempo) {
    _tempoLeitura = tempo;
    notifyListeners();
  }

  void registrarClique() {
    _cliques++;
    notifyListeners();
  }

  void registrarJogador() {
    _totalJogadores++;
    notifyListeners();
  }

  void registrarFeedback(String feedback) {
    _feedback.add(feedback);
    notifyListeners();
  }
}
