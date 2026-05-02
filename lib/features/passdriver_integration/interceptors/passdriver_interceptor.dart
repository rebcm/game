import 'package:http_interceptor/http_interceptor.dart';
import 'package:http/http.dart' as http;

class PassdriverInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    // Implement request interception logic here
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    // Implement response interception logic here
    return data;
  }
}
