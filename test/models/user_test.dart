import 'package:flutter_test/flutter_test.dart';
import 'package:game/models/user.dart';

void main() {
  test('User.fromJson', () {
    final json = {'id': '1', 'name': 'Rebeca'};
    final user = User.fromJson(json);
    expect(user.id, '1');
    expect(user.name, 'Rebeca');
  });

  test('User.toJson', () {
    final user = User(id: '1', name: 'Rebeca');
    final json = user.toJson();
    expect(json['id'], '1');
    expect(json['name'], 'Rebeca');
  });
}
