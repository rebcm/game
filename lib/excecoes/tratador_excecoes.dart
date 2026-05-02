import 'package:flutter/material.dart';

class TratadorExcecoes with FlutterErrorDetails {
  static void tratarExcecao(FlutterErrorDetails detalhes) {
    FlutterError.dumpErrorToConsole(detalhes);
    _exibirMensagemErro(detalhes.exceptionAsString());
  }

  static void _exibirMensagemErro(String mensagem) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) => AlertDialog(
          title: Text('Erro'),
          content: Text(mensagem),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    });
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
