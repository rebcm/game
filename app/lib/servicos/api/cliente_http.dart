import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';

class ClienteHttp {
  static http.Client criarCliente() {
    return InterceptedClient.build(
      interceptors: [
        AutenticacaoInterceptor(),
      ],
      requestTimeout: Duration(seconds: 10),
    );
  }
}

class AutenticacaoInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    // Implementar lógica de autenticação aqui
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    return data;
  }
}
