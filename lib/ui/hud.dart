import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/i18n/i18n_service.dart';

class HUD extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(I18nService.translate(context, 'inventario')),
    );
  }
}
