import 'package:rebcm/services/chunking/chunk_versioning_strategy.dart';
import 'package:intl/intl.dart';

class TimestampChunkVersioningStrategy implements ChunkVersioningStrategy {
  @override
  String getVersion(String chunkId) {
    return DateFormat('yyyyMMddHHmmss').format(DateTime.now());
  }
}
