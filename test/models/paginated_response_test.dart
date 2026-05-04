import 'package:flutter_test/flutter_test.dart';
import 'package:game/models/paginated_response.dart';

void main() {
  test('deve desserializar resposta paginada corretamente', () {
    final json = {
      'data': ['item1', 'item2'],
      'page': 1,
      'limit': 10,
      'total': 2,
    };

    final response = PaginatedResponse<String>.fromJson(json, (json) => json as String);

    expect(response.data, ['item1', 'item2']);
    expect(response.page, 1);
    expect(response.limit, 10);
    expect(response.total, 2);
  });
}
