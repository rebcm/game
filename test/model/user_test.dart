import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/model/user.dart';

void main() {
  test('User.fromJson should correctly parse JSON', () {
    final jsonData = jsonDecode('{"name": "Rebeca", "age": 25}');
    final user = User.fromJson(jsonData);
    expect(user.name, 'Rebeca');
    expect(user.age, 25);
  });
}
