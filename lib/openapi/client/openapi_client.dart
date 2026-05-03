import 'package:dio/dio.dart';

class OpenApiClient {
  final Dio _dio;

  OpenApiClient(this._dio);

  Future<List<Block>> getBlocks() async {
    final response = await _dio.get('/blocks');
    return (response.data as List).map((e) => Block.fromJson(e)).toList();
  }
}

class Block {
  final int id;
  final String name;

  Block({required this.id, required this.name});

  factory Block.fromJson(Map<String, dynamic> json) {
    return Block(id: json['id'], name: json['name']);
  }
}
