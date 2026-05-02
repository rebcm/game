import 'package:flutter/material.dart';
import 'package:http_interceptor/http_interceptor.dart';
class PassdriverInterceptor with InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    // Add logic to modify request data if needed
    return data;
  }
  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    // Add logic to modify response data if needed
    return data;
  }
}
