import 'package:game/openapi/client.dart';

class PassdriverService {
  final ApiClient _apiClient;

  PassdriverService(this._apiClient);

  Future<List<User>> getUsers() async {
    final usersApi = UsersApi(_apiClient);
    final users = await usersApi.getUsers();
    return users;
  }
}
