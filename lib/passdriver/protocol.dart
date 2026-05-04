class PassdriverProtocol {
  static const int version = 0x0001;

  static const int compressionNone = 0x00;
  static const int compressionLZ4 = 0x01;

  final int versionProtocol;
  final int compressionType;
  final int payloadSize;
  final List<int> payload;

  PassdriverProtocol({
    required this.versionProtocol,
    required this.compressionType,
    required this.payloadSize,
    required this.payload,
  });

  factory PassdriverProtocol.fromBytes(List<int> bytes) {
    if (bytes.length < 7) {
      throw ArgumentError('Bytes insuficientes para formar um frame válido');
    }

    final versionProtocol = (bytes[0] << 8) | bytes[1];
    final compressionType = bytes[2];
    final payloadSize =
        (bytes[3] << 24) | (bytes[4] << 16) | (bytes[5] << 8) | bytes[6];

    final payload = bytes.sublist(7);

    return PassdriverProtocol(
      versionProtocol: versionProtocol,
      compressionType: compressionType,
      payloadSize: payloadSize,
      payload: payload,
    );
  }

  List<int> toBytes() {
    final bytes = <int>[];

    bytes.add((versionProtocol >> 8) & 0xFF);
    bytes.add(versionProtocol & 0xFF);
    bytes.add(compressionType);
    bytes.add((payloadSize >> 24) & 0xFF);
    bytes.add((payloadSize >> 16) & 0xFF);
    bytes.add((payloadSize >> 8) & 0xFF);
    bytes.add(payloadSize & 0xFF);

    bytes.addAll(payload);

    return bytes;
  }
}
