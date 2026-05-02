import 'package:http_interceptor/http_interceptor.dart';
import 'passdriver_interceptor.dart';
class InterceptorClient {
  static HttpClientWithInterceptor getClient() {
    return HttpClientWithInterceptor.build(interceptors: [PassdriverInterceptor()]);
  }
}
