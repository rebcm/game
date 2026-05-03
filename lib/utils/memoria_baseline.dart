import 'dart:developer';

class MemoriaBaseline {
  static void registrarBaseline() {
    final memoriaInicial = MemoryInfo().currentRSS;
    log('Memória inicial: $memoriaInicial bytes');
    // Implementar lógica para registrar baseline de memória
  }

  static void registrarBaselineAposDestruicao() {
    final memoriaAposDestruicao = MemoryInfo().currentRSS;
    log('Memória após destruição: $memoriaAposDestruicao bytes');
    // Implementar lógica para registrar baseline de memória após destruição do estado_jogo.dart
  }
}

class MemoryInfo {
  static int get currentRSS {
    // Implementar lógica para obter o uso atual de memória RSS
    // Para fins de exemplo, vamos considerar um valor fixo
    return 1024 * 1024 * 50; // 50 MB
  }
}
