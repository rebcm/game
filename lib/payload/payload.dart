import 'dart:typed_data';
import 'package:crypto/crypto.dart';

class Payload {
  static const int _compressionFlagOffset = 0;
  static const int _checksumOffset = 1;
  static const int _dataOffset = 5;

  Uint8List _data;

  Payload(this._data);

  factory Payload.fromData(Uint8List data, {bool compress = false}) {
    var payloadData = compress ? _compress(data) : data;
    var checksum = _calculateChecksum(payloadData);
    var frame = Uint8List(_dataOffset + payloadData.length);
    frame[_compressionFlagOffset] = compress ? 0x01 : 0x00;
    frame.setRange(_checksumOffset, _dataOffset, checksum);
    frame.setRange(_dataOffset, frame.length, payloadData);
    return Payload(frame);
  }

  Uint8List get data => _data;

  bool get isCompressed => _data[_compressionFlagOffset] == 0x01;

  Uint8List get payloadData {
    var data = _data.sublist(_dataOffset);
    return isCompressed ? _decompress(data) : data;
  }

  static Uint8List _compress(Uint8List data) {
    // Implementação da compressão
    throw UnimplementedError('Compressão não implementada');
  }

  static Uint8List _decompress(Uint8List data) {
    // Implementação da descompressão
    throw UnimplementedError('Descompressão não implementada');
  }

  static Uint8List _calculateChecksum(Uint8List data) {
    var crc32 = Crc32();
    return Uint8List.fromList(crc32.convert(data).bytes);
  }
}

