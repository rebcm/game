import 'package:flutter/material.dart';
import 'package:game/config/tip_config.dart';

abstract class TipStrategy {
  void showTip(BuildContext context, String message);
}

class ToastTipStrategy implements TipStrategy {
  @override
  void showTip(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}

class OverlayTipStrategy implements TipStrategy {
  @override
  void showTip(BuildContext context, String message) {
    // Implement overlay logic here
  }
}

TipStrategy getTipStrategy() {
  switch (TipConfig.displayStrategy) {
    case TipDisplayStrategy.toast:
      return ToastTipStrategy();
    case TipDisplayStrategy.overlay:
      return OverlayTipStrategy();
    default:
      throw Exception('Unsupported tip display strategy');
  }
}
