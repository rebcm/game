import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:http/http.dart' as http;

class StorageLimitMock {
  final DioAdapter _dioAdapter;

  StorageLimitMock(this._dioAdapter);

  void mockStorageLimitExceeded() {
    _dioAdapter.onGet(
      'https://example.com/storage-limit',
      (server) => server.reply(
        403,
        {'error': 'Storage limit exceeded'},
      ),
    );
  }

  void mockStorageWithinLimit() {
    _dioAdapter.onGet(
      'https://example.com/storage-limit',
      (server) => server.reply(
        200,
        {'available': true},
      ),
    );
  }
}
