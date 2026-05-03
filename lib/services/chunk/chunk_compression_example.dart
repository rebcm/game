import 'package:rebcm/services/chunk/chunk_compression_service.dart';

void main() async {
  final service = ChunkCompressionService();
  final originalData = Uint8List.fromList([1, 2, 3, 4, 5]);
  final compressedData = await service.compressChunk(originalData);
  final decompressedData = await service.decompressChunk(compressedData);
  print(decompressedData);
}
