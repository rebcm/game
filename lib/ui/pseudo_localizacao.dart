import 'package:intl/intl.dart';

class PseudoLocalizacao {
  static String traduzir(String texto) {
    return Intl.message(
      texto,
      desc: 'Pseudo-localização para teste de layout',
      name: texto.replaceAll(' ', '_').toUpperCase(),
    ).replaceAll(RegExp(r'[a-zA-Z]'), (match) {
      String char = match.group(0)!;
      if (char.toUpperCase() == char) {
        return String.fromCharCode(char.codeUnitAt(0) + 3);
      } else {
        return String.fromCharCode(char.codeUnitAt(0) + 5);
      }
    });
  }
}
