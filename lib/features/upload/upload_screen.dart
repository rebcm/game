import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:passdriver/features/upload/upload_provider.dart';

class UploadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UploadProvider(),
      child: Consumer<UploadProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  final filePath = '/path/to/file';
                  final uploaded = await provider.uploadFile(filePath);
                  if (uploaded) {
                    final checksumVerified = await provider.verifyChecksum(filePath, 'expected_checksum');
                    if (!checksumVerified) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Erro ao verificar checksum')),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Erro ao enviar arquivo')),
                    );
                  }
                },
                child: Text('Enviar Arquivo'),
              ),
            ],
          );
        },
      ),
    );
  }
}
