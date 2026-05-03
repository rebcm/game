// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'openapi_client.dart';

// **************************************************************************
// DioGenerator
// **************************************************************************

class _OpenApiClient implements OpenApiClient {
  _OpenApiClient(this._dio);

  final Dio _dio;

  @override
  Future<List<Block>> getBlocks() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<Block>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/blocks',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => Block.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
