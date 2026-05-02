import 'package:flutter/material.dart';
import 'package:passdriver/features/retry_logic/domain/retry_repository.dart';

class RetryProvider with ChangeNotifier {
  final RetryRepository _repository;

  RetryProvider(this._repository);

  Future<void> makeRequestWithRetry(Uri url) async {
    try {
      final response = await _repository.makeRequest(url);
      // Handle successful response
    } catch (e) {
      // Handle error
    }
  }
}
