import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/storage_service.dart';
import 'package:mockito/mockito.dart';
import '../test/mocks/lib/services/storage/mock_storage_service.dart';

void configureTest() {
  TestWidgetsFlutterBinding.ensureInitialized();
  StorageService.instance = FakeStorageService();
}
