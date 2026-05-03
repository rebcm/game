import 'dart:typed_data';
import 'package:protobuf/protobuf.dart';

class ChunkData extends GeneratedMessage {
  @override
  List<int> get data => $_getInt64List(1);

  @override
  void set data(List<int> v) => $_setInt64List(1, v);

  @override
  bool hasData() => $_has(1);

  @override
  void clearData() => clearField(1);
}

class ProtobufChunkSerializer {
  Uint8List serialize(Uint8List data) {
    final chunkData = ChunkData()..data = data;
    return chunkData.writeToBuffer();
  }

  Uint8List deserialize(Uint8List data) {
    final chunkData = ChunkData.fromBuffer(data);
    return Uint8List.fromList(chunkData.data);
  }
}
