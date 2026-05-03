import 'package:flutter_test/flutter_test.dart';
import 'package:game/models/block_documentation/block_documentation.dart';
import 'package:game/models/block_documentation/block_documentation_list.dart';

void main() {
  group('BlockDocumentation', () {
    test('fromJson', () {
      final json = {'id': '1', 'name': 'Test Block', 'description': 'This is a test block'};
      final block = BlockDocumentation.fromJson(json);
      expect(block.id, '1');
      expect(block.name, 'Test Block');
      expect(block.description, 'This is a test block');
    });

    test('toJson', () {
      final block = BlockDocumentation(id: '1', name: 'Test Block', description: 'This is a test block');
      final json = block.toJson();
      expect(json['id'], '1');
      expect(json['name'], 'Test Block');
      expect(json['description'], 'This is a test block');
    });
  });

  group('BlockDocumentationList', () {
    test('fromJson', () {
      final json = {'blocks': [{'id': '1', 'name': 'Test Block', 'description': 'This is a test block'}]};
      final list = BlockDocumentationList.fromJson(json);
      expect(list.blocks.length, 1);
      expect(list.blocks.first.id, '1');
      expect(list.blocks.first.name, 'Test Block');
      expect(list.blocks.first.description, 'This is a test block');
    });

    test('toJson', () {
      final block = BlockDocumentation(id: '1', name: 'Test Block', description: 'This is a test block');
      final list = BlockDocumentationList(blocks: [block]);
      final json = list.toJson();
      expect(json['blocks'].length, 1);
      expect(json['blocks'][0]['id'], '1');
      expect(json['blocks'][0]['name'], 'Test Block');
      expect(json['blocks'][0]['description'], 'This is a test block');
    });
  });
}
