import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ControlesWebDesktop extends StatefulWidget {
  @override
  _ControlesWebDesktopState createState() => _ControlesWebDesktopState();
}

class _ControlesWebDesktopState extends State<ControlesWebDesktop> {
  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.keyW) ||
            event.isKeyPressed(LogicalKeyboardKey.keyA) ||
            event.isKeyPressed(LogicalKeyboardKey.keyS) ||
            event.isKeyPressed(LogicalKeyboardKey.keyD)) {
          // Lógica para WASD
        }
      },
      child: Listener(
        onPointerSignal: (event) {
          if (event is PointerScrollEvent) {
            // Lógica para scroll
          }
        },
        child: GestureDetector(
          onTap: () {
            // Lógica para clique esquerdo
          },
          onSecondaryTap: () {
            // Lógica para clique direito
          },
          child: Container(
            // Container para o mapa ou outros elementos
          ),
        ),
      ),
    );
  }
}
