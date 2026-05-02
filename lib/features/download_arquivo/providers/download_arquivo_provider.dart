import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DownloadArquivoProvider with ChangeNotifier {
  final Dio _dio = Dio();

  Future<bool> downloadArquivo(String url, String savePath) async {
    try {
      await _dio.download(url, savePath, onReceiveProgress: (received, total) {
        if (total != -1) {
          print((received / total * 100).toStringAsFixed(0) + "%");
        }
      });
      return true;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError || e.type == DioExceptionType.receiveTimeout || e.type == DioExceptionType.sendTimeout) {
        return false;
      } else {
        rethrow;
      }
    }
  }

  Future<bool> downloadArquivoComRetry(String url, String savePath, {int maxAttempts = 3}) async {
    int attempts = 0;
    while (attempts < maxAttempts) {
      if (await downloadArquivo(url, savePath)) {
        return true;
      }
      attempts++;
      await Future.delayed(const Duration(seconds: 1));
    }
    return false;
  }
}
