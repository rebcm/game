import 'package:flutter/animation.dart';
import 'package:rebcm/personagem/rebeca.dart';

class AnimacaoAndar {
  static const double fpsMinimo = 24.0;
  static const double fpsIdeal = 60.0;

  final Rebeca rebeca;

  AnimacaoAndar(this.rebeca);

  void atualizar() {
    if (rebeca.estaAndando) {
      rebeca.animacaoController.forward(from: 0);
    } else {
      rebeca.animacaoController.stop();
    }
  }

  bool get estaSincronizada {
    final diferencaBracoPerna = (rebeca.bracoAnimacao.value - rebeca.pernaAnimacao.value).abs();
    return diferencaBracoPerna < 0.1;
  }

  bool get atendeFpsMinimo {
    return rebeca.animacaoController.lastElapsedDuration?.inMilliseconds ?? 0 > (1000 ~/ fpsMinimo);
  }
}
