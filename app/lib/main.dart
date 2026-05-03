import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rebcm/constantes.dart';
import 'package:rebcm/jogo/construcao_criativa.dart';
import 'package:rebcm/ui/controles_overlay.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  runApp(const GameApp());
}

class GameApp extends StatelessWidget {
  const GameApp({super.key});

  @override
  Widget build(BuildContext context) {
    final game = ConstrucaoCriativa();
    return MaterialApp(
      title: Constantes.nomejogo,
      debugShowCheckedModeBanner: false,
      home: GameWidget(
        game: game,
        overlayBuilderMap: {
          'controles': (context, g) => ControlesOverlay(game: g as ConstrucaoCriativa),
        },
      ),
    );
  }
}
