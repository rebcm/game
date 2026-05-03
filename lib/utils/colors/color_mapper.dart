import 'package:flutter/material.dart';
import 'package:game/utils/colors/design_tokens.dart';

class ColorMapper {
  static Color mapDesignTokenToColor(String designToken) {
    switch (designToken) {
      case 'primaryColor':
        return DesignTokens.primaryColor;
      case 'secondaryColor':
        return DesignTokens.secondaryColor;
      // Add more cases as needed
      default:
        throw Exception('Unknown design token: $designToken');
    }
  }
}
