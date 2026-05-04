import 'package:flutter_test/flutter_test.dart';
import 'package:game/openapi/client.dart';
import 'package:game/services/passdriver_service.dart';
import 'package:mockito/mockito.dart';

class MockApiClient extends Mock implements ApiClient {}

class MockUsersApi extends Mock implements UsersApi {}

void main() {
  group('PassdriverService', () {
    late PassdriverService service;
    late MockApiClient apiClient;
    late MockUsersApi usersApi;

    setUp(() {
      apiClient = MockApiClient();
      usersApi = MockUsersApi();
      when(apiClient.createUsersApi()).thenReturn(usersApi);
      service = PassdriverService(apiClient);
    });

    test('getUsers returns users', () async {
      final users = [User(id: 1, name: 'John')];
      when(usersApi.getUsers()).thenAnswer((_) async => users);
      final result = await service.getUsers();
      expect(result, users);
    });
  });
}
