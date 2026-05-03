import 'package:flutter/material.dart';

class TipService {
  static TipService? _instance;

  factory TipService() => _instance ??= TipService._();

  TipService._();

  void showTip(BuildContext context, String message) {
    // Implement tip display logic here, e.g., using a Toast or Overlay
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
