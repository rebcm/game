import 'package:flutter/material.dart';

class InstallationGuide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guia de Instalação'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('Guia de instalação do PassDriver'),
      ),
    );
  }
}
