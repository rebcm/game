import 'dart:convert';
import 'dart:typed_data';

class JsonChunkSerializer {
  Uint8List serialize(Uint8List data) {
    final jsonData = {'data': base64Encode(data)};
    return Uint8List.fromList(utf8.encode(jsonEncode(jsonData)));
  }

  Uint8List deserialize(Uint8List data) {
    final jsonData = jsonDecode(utf8.decode(data));
    return base64Decode(jsonData['data']);
  }
}
