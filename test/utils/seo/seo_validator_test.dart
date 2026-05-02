import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/utils/seo/seo_validator.dart';

void main() {
  group('SeoValidator', () {
    test('validateDescription returns false for empty description', () {
      expect(SeoValidator.validateDescription(''), false);
    });

    test('validateDescription returns false if required keywords are missing', () {
      expect(SeoValidator.validateDescription('This is a game'), false);
    });

    test('validateDescription returns true if all required keywords are present', () {
      expect(SeoValidator.validateDescription('This is a voxel game with rebeca in criativo mode building blocos'), true);
    });

    test('validateDescription is case-insensitive', () {
      expect(SeoValidator.validateDescription('VOXEL REBECA CRIATIVO BLOCOS GAME'), true);
    });
  });
}
