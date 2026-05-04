import 'package:flutter/material.dart';
import 'package:game/i18n/i18n.dart';

class GuiaConstrucao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(I18n.of(context).tr('guia_construcao_titulo')),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(I18n.of(context).tr('guia_construcao_dicas')),
            Text(I18n.of(context).tr('guia_construcao_template')),
          ],
        ),
      ),
    );
  }
}
