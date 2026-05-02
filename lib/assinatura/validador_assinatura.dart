import 'dart:io';

class ValidadorAssinatura {
  static Future<bool> validarAssinaturaAndroid(String caminhoApk) async {
    final resultado = await Process.run('apksigner', ['verify', '--verbose', caminhoApk]);
    return resultado.exitCode == 0;
  }

  static Future<bool> validarAssinaturaIos(String caminhoIpa) async {
    final resultado = await Process.run('codesign', ['--verify', '--verbose', caminhoIpa]);
    return resultado.exitCode == 0;
  }
}
