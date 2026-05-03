import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/block.dart';

class BlockService {
  Future<List<Block>> getBlocks() async {
    final response = await http.get(Uri.parse('https://example.com/blocks'));

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((data) => Block.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load blocks');
    }
  }
}
