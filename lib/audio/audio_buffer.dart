import 'dart:async';
import 'package:flutter/foundation.dart';

class AudioBuffer with ChangeNotifier {
  List<int> _buffer = [];
  bool _isConnected = true;
  Timer? _reconnectionTimer;

  List<int> get buffer => _buffer;

  bool get isConnected => _isConnected;

  void addAudioData(List<int> data) {
    if (_isConnected) {
      _buffer.addAll(data);
      notifyListeners();
    }
  }

  void _reconnect() {
    _isConnected = true;
    _reconnectionTimer = null;
    notifyListeners();
  }

  void onConnectionLost() {
    _isConnected = false;
    _reconnectionTimer ??= Timer.periodic(Duration(seconds: 5), (timer) {
      // Simulate reconnection logic
      _reconnect();
    });
    notifyListeners();
  }

  @override
  void dispose() {
    _reconnectionTimer?.cancel();
    super.dispose();
  }
}
