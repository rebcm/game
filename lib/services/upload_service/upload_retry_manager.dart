import 'package:http/http.dart' as http;

class UploadRetryManager {
  static const int _maxRetries = 3;
  static const Duration _initialDelay = Duration(seconds: 1);
  static const double _backoffFactor = 2.0;

  Future<bool> retryUpload(Future<bool> Function() uploadOperation) async {
    int attempt = 0;
    Duration delay = _initialDelay;

    while (attempt < _maxRetries) {
      try {
        return await uploadOperation();
      } catch (e) {
        attempt++;
        await Future.delayed(delay);
        delay *= _backoffFactor;
      }
    }
    return false;
  }
}
