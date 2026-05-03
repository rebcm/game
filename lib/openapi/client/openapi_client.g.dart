// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'openapi_client.dart';

// **************************************************************************
// OpenApiClientGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names

class OpenApiClientGenerated {
  final http.Client _client;

  OpenApiClientGenerated(this._client);

  Future<http.Response> example() async {
    return await _client.get(Uri.parse('https://example.com/example'));
  }
}
