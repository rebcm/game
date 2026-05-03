import 'package:mockito/mockito.dart';
import 'package:game/services/storage_service.dart';

class MockStorageService extends Mock implements StorageService {}

class FakeStorageService implements StorageService {
  @override
  Future<void> clearCache() async {}

  @override
  Future<String?> getString(String key) async => null;

  @override
  Future<void> setString(String key, String value) async {}
}
