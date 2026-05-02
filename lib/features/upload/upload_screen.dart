import 'package:flutter/material.dart';
import 'package:passdriver/features/upload/upload_chunk_provider.dart';
import 'package:provider/provider.dart';

class UploadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UploadChunkProvider(R2Service()),
      child: Consumer<UploadChunkProvider>(
        builder: (context, provider, child) {
          return ElevatedButton(
            onPressed: () async {
              try {
                await provider.uploadChunk('chunk', 'metadataId');
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Falha no upload: ')),
                );
              }
            },
            child: Text('Upload'),
          );
        },
      ),
    );
  }
}
