import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/data_service/data_service.dart';
import 'dart:typed_data';

void main() {
  group('DataService', () {
    test('compressData and decompressData', () async {
      final dataService = DataService();
      final originalData = Uint8List.fromList([1, 2, 3, 4, 5]);
      final compressedData = await dataService.compressData(originalData);
      final decompressedData = await dataService.decompressData(compressedData);

      expect(decompressedData, originalData);
    });
  });
}
