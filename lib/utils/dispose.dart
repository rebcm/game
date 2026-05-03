import 'package:flutter/material.dart';

class DisposeController {
  final List<VoidCallback> _disposables = [];

  void addDisposable(VoidCallback disposable) {
    _disposables.add(disposable);
  }

  void dispose() {
    for (var disposable in _disposables) {
      disposable();
    }
    _disposables.clear();
  }
}
