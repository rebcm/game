import 'dart:isolate';
import 'package:flutter/foundation.dart';

void main() async {
  final sendPort = await receivePort.first;
  sendPort.send(null);
}

late ReceivePort receivePort;

void initForceGc() {
  receivePort = ReceivePort();
  Isolate.spawn(main, receivePort.sendPort);
}

void forceGC() async {
  final completer = Completer();
  final receivePort = ReceivePort();
  receivePort.listen((_) {
    completer.complete();
  });
  Isolate.spawn(main, receivePort.sendPort);
  await completer.future;
}
