import 'package:flutter/material.dart';
import 'package:game/widgets/overflow_protection_widget.dart';
import 'package:game/widgets/scrollable_text_widget.dart';

class UIUtils {
  static Widget protectOverflow(String text) {
    return OverflowProtectionWidget(text: text);
  }

  static Widget makeScrollableText(String text) {
    return ScrollableTextWidget(text: text);
  }
}
