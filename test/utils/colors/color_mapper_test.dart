import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/utils/colors/color_mapper.dart';
import 'package:rebcm/utils/colors/design_tokens.dart';
import 'package:rebcm/utils/colors/flutter_colors.dart';

void main() {
  test('ColorMapper maps design tokens to Flutter colors correctly', () {
    final colorMap = ColorMapper.mapDesignTokensToFlutterColors();
    expect(colorMap[DesignTokens.primaryColor], FlutterColors.primaryColor);
    expect(colorMap[DesignTokens.secondaryColor], FlutterColors.secondaryColor);
    // Add other test cases here
  });
}
