import 'package:flutter/material.dart';
import 'package:passdriver/services/r2_service.dart';

class UploadChunkProvider with ChangeNotifier {
  final R2Service _r2Service;

  UploadChunkProvider(this._r2Service);

  Future<void> uploadChunk(String chunk, String metadataId) async {
    try {
      await _r2Service.uploadChunk(chunk, metadataId);
    } catch (e) {
      await _r2Service.removeMetadata(metadataId);
      rethrow;
    }
  }
}
