import 'dart:async';

class GameStreams {
  final StreamController _streamController = StreamController();

  Stream get stream => _streamController.stream;

  void addData(data) => _streamController.add(data);

  void close() => _streamController.close();
}
