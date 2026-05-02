class Validations {
  static bool isValidUserId(String userId) {
    return userId.isNotEmpty && userId.length <= 50;
  }

  static bool isValidWorldData(String worldData) {
    return worldData.isNotEmpty && worldData.length <= 1024 * 1024; // 1MB
  }
}
