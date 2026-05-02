import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RideHailingProvider with ChangeNotifier {
  int _chunkSize = 10;

  int get chunkSize => _chunkSize;

  void updateChunkSize(int size) {
    _chunkSize = size;
    notifyListeners();
  }
}
