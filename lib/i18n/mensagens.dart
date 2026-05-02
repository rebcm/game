import 'package:intl/intl.dart';

class Mensagens {
  static String get descricaoJogo => Intl.message(
        'Construção Criativa',
        name: 'descricaoJogo',
        desc: 'Descrição do jogo',
      );

  static String get tituloJogo => Intl.message(
        'Rebeca\'s Game',
        name: 'tituloJogo',
        desc: 'Título do jogo',
      );
}
