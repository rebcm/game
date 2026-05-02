import 'package:flutter/material.dart';
import 'package:rebcm/i18n/i18n_service.dart';

class Jogo extends StatelessWidget {
  const Jogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(I18nService().gameTitle),
      ),
      body: Center(
        child: Text(I18nService().block),
      ),
    );
  }
}
