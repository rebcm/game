import 'package:flutter/material.dart';

class TipService {
  static TipService? _instance;

  factory TipService() {
    _instance ??= TipService._();
    return _instance!;
  }

  TipService._();

  void showTip(BuildContext context, String message) {
    // Implement tip display logic here, e.g., using a Snackbar or Tooltip
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void hideTip(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}
