import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/api_service/error_handling/api_error_model.dart';

void main() {
  test('ApiErrorModel fromJson', () {
    final json = {'error': 'code', 'message': 'text'};
    final model = ApiErrorModel.fromJson(json);
    expect(model.error, 'code');
    expect(model.message, 'text');
  });
}
