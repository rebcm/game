import 'package:flutter/material.dart';
import 'package:rebcm/i18n/i18n_service.dart';

class Jogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).gameTitle),
      ),
      body: Center(
        child: Text(AppLocalizations.of(context).blockGrass),
      ),
    );
  }
}
