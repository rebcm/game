import 'package:flutter/material.dart';
import 'package:rebcm/widgets/dicas_construcao.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DicasConstrucao(),
          ],
        ),
      ),
    );
  }
}
