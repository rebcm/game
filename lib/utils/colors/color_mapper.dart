import 'package:flutter/material.dart';
import 'package:rebcm/utils/colors/design_tokens.dart';
import 'package:rebcm/utils/colors/flutter_colors.dart';

class ColorMapper {
  static Map<DesignTokens, Color> mapDesignTokensToFlutterColors() {
    return {
      DesignTokens.primaryColor: FlutterColors.primaryColor,
      DesignTokens.secondaryColor: FlutterColors.secondaryColor,
      // Add other mappings here
    };
  }
}
