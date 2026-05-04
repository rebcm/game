import 'package:dio/dio.dart';

class PaginationService {
  final Dio _dio;

  PaginationService(this._dio);

  Future<Response> fetchPaginatedList(String endpoint, int page, int limit) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: {'page': page, 'limit': limit});
      return response;
    } on DioException catch (e) {
      throw Exception('Falha ao carregar lista paginada: $e');
    }
  }
}
