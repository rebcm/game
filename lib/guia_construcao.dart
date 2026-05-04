import 'package:flutter/material.dart';
import 'package:game/i18n/localization.dart';

class GuiaConstrucao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.of(context).translate('guia_construcao_titulo')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(Localization.of(context).translate('guia_construcao_introducao')),
            SizedBox(height: 16),
            Text(Localization.of(context).translate('guia_construcao_dicas_titulo')),
            SizedBox(height: 8),
            ListTile(
              title: Text(Localization.of(context).translate('guia_construcao_dicas_planejamento')),
            ),
            ListTile(
              title: Text(Localization.of(context).translate('guia_construcao_dicas_uso_blocos')),
            ),
            ListTile(
              title: Text(Localization.of(context).translate('guia_construcao_dicas_simetria_proporcao')),
            ),
            ListTile(
              title: Text(Localization.of(context).translate('guia_construcao_dicas_experimentacao')),
            ),
            SizedBox(height: 16),
            Text(Localization.of(context).translate('guia_construcao_templates_titulo')),
            SizedBox(height: 8),
            ListTile(
              title: Text(Localization.of(context).translate('guia_construcao_templates_casa_simples')),
            ),
            ListTile(
              title: Text(Localization.of(context).translate('guia_construcao_templates_torre')),
            ),
          ],
        ),
      ),
    );
  }
}
