import 'package:passdriver/features/retry_logic/data/retry_data_source.dart';

class RetryRepository {
  final RetryDataSource _dataSource;

  RetryRepository(this._dataSource);

  Future<http.Response> makeRequest(Uri url) async {
    return _dataSource.makeRequestWithRetry(url);
  }
}
