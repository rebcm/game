import 'dart:isolate';
import 'package:rebcm/models/chunk.dart';

class MeshGeneratorIsolate {
  static Future<SendPort> _getIsolate() async {
    final receivePort = ReceivePort();
    await Isolate.spawn(_meshGeneratorIsolate, receivePort.sendPort);
    return await receivePort.first;
  }

  static void _meshGeneratorIsolate(SendPort sendPort) async {
    final receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);
    await for (var message in receivePort) {
      if (message is Chunk) {
        final mesh = _generateMesh(message);
        sendPort.send(mesh);
      }
    }
  }

  static dynamic _generateMesh(Chunk chunk) {
    // Implement mesh generation logic here
    return null;
  }

  static Future<dynamic> generateMesh(Chunk chunk) async {
    final sendPort = await _getIsolate();
    final receivePort = ReceivePort();
    sendPort.send(chunk);
    sendPort.send(receivePort.sendPort);
    return await receivePort.first;
  }
}
