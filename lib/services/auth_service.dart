class AuthService {
  String? _userId;

  String? get userId => _userId;

  void login(String userId) {
    _userId = userId;
  }

  void logout() {
    _userId = null;
  }
}
