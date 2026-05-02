import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:game/personagem/rebeca.dart';

class Controles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rebeca = Provider.of<Rebeca>(context);
    return Column(
      children: [
        // Joystick virtual esquerdo
        Joystick(
          onChanged: (details) {
            rebeca.mover(details.x, details.y);
          },
        ),
        // Botão A
        ElevatedButton(
          onPressed: () {
            rebeca.pular();
          },
          child: Text('A'),
        ),
        // Botão mochila
        ElevatedButton(
          onPressed: () {
            // Abrir inventário
          },
          child: Text('Mochila'),
        ),
      ],
    );
  }
}

class Joystick extends StatefulWidget {
  final Function(DragUpdateDetails) onChanged;

  Joystick({required this.onChanged});

  @override
  _JoystickState createState() => _JoystickState();
}

class _JoystickState extends State<Joystick> {
  Offset _offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        _offset = details.localPosition;
        widget.onChanged(details);
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
