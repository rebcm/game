import 'package:http/http.dart' as http;

class CompressionService {
  bool isCompressionSupported(Map<String, String> headers) {
    final acceptEncoding = headers['accept-encoding'];
    return acceptEncoding != null && acceptEncoding.contains('gzip');
  }
}
