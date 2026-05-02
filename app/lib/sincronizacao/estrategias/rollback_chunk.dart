import 'package:dio/dio.dart';

class RollbackChunk {
  final Dio _dio;

  RollbackChunk(this._dio);

  Future<void> executar(String chunkId) async {
    try {
      await _dio.delete('/chunks/$chunkId');
      await _removerMetadado(chunkId);
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        await _removerMetadado(chunkId);
      } else {
        throw Exception('Falha ao executar rollback do chunk $chunkId: $e');
      }
    }
  }

  Future<void> _removerMetadado(String chunkId) async {
    // Implementar lógica para remover metadado do chunk
    // Utilizar shared_preferences ou outro mecanismo de armazenamento local
    // Exemplo com shared_preferences:
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.remove('chunk_$chunkId');
  }
}
