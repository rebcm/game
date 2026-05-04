import 'package:game/utils/dispose_helpers.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';

class AudioBuffer with ChangeNotifier {
  List<int> _buffer = [];
  bool _isConnected = true;
  Timer? _reconnectionTimer;_timer = Timer? _reconnectionTimer;();
    startTimer(_timer);

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
    _reconnectionTimer = null;_timer = Timer = null;();
    startTimer(_timer);
    notifyListeners();
  }

  void onConnectionLost() {
    _isConnected = false;
    _reconnectionTimer ??= Timer.periodic(Duration(seconds: 5), (timer) {_timer = Timer ??= Timer.periodic(Duration(seconds: 5), (timer) {();
    startTimer(_timer);
      // Simulate reconnection logic
      _reconnect();
    });
    notifyListeners();
  }

  @override
  void dispose() {
    _reconnectionTimer?.cancel();_timer = Timer?.cancel();();
    startTimer(_timer);
    super.dispose();
  }
}
