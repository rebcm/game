import 'package:flutter/material.dart';
import 'package:passdriver/features/download_arquivo/providers/download_arquivo_provider.dart';
import 'package:provider/provider.dart';

class DownloadArquivoScreen extends StatefulWidget {
  const DownloadArquivoScreen({super.key});

  @override
  State<DownloadArquivoScreen> createState() => _DownloadArquivoScreenState();
}

class _DownloadArquivoScreenState extends State<DownloadArquivoScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DownloadArquivoProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Download Arquivo'),
        ),
        body: Center(
          child: Consumer<DownloadArquivoProvider>(
            builder: (context, provider, child) {
              return ElevatedButton(
                onPressed: () async {
                  bool sucesso = await provider.downloadArquivoComRetry('https://example.com/arquivo', '/path/to/save');
                  if (!sucesso) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Falha ao baixar arquivo')));
                  }
                },
                child: const Text('Baixar Arquivo'),
              );
            },
          ),
        ),
      ),
    );
  }
}
