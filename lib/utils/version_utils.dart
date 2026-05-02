class VersionUtils {
  static bool isValidFlutterVersion(String version) {
    return version == '3.0.0';
  }

  static bool isValidDartVersion(String version) {
    return version.startsWith('2.17.');
  }
}
