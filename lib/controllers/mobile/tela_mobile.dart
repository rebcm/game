import 'package:flutter/material.dart';
import 'package:rebcm/widgets/mobile/joystick_esquerdo.dart';
import 'package:rebcm/widgets/mobile/joystick_direito.dart';
import 'package:rebcm/widgets/mobile/botao_a.dart';
import 'package:rebcm/widgets/mobile/botao_mochila.dart';

class TelaMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          JoystickEsquerdo(),
          Positioned(
            right: 0,
            child: JoystickDireito(),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: BotaoA(),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: BotaoMochila(),
          ),
        ],
      ),
    );
  }
}
