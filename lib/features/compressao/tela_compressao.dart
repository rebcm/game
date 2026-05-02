import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'compressao_provider.dart';

class TelaCompressao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CompressaoProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Definição de KPIs de Compressão'),
        ),
        body: Consumer<CompressaoProvider>(
          builder: (context, compressaoProvider, child) {
            return Column(
              children: [
                Text('Bitrate Mínimo: ${compressaoProvider.bitrateMinimo} kbps'),
                Slider(
                  value: compressaoProvider.bitrateMinimo,
                  min: 64,
                  max: 256,
                  divisions: 8,
                  label: compressaoProvider.bitrateMinimo.round().toString(),
                  onChanged: (value) => compressaoProvider.atualizaBitrateMinimo(value),
                ),
                Text('Tamanho Binário Original: ${compressaoProvider.tamanhoBinarioOriginal} bytes'),
                Text('Tamanho Binário Comprimido: ${compressaoProvider.tamanhoBinarioComprimido} bytes'),
                Text('Taxa de Compressão: ${compressaoProvider.taxaCompressao}%'),
              ],
            );
          },
        ),
      ),
    );
  }
}
