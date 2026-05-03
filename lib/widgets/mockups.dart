import 'package:flutter/material.dart';

class TooltipMockup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Exemplo de Tooltip',
      child: Image.asset('assets/mockups/tooltip_mockup.png'),
    );
  }
}

class AjudaMockup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset('assets/mockups/ajuda_mockup.png'),
    );
  }
}

class ModalMockup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Exemplo de Modal'),
      children: [
        Image.asset('assets/mockups/modal_mockup.png'),
      ],
    );
  }
}
