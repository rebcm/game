import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/deployment_service.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('DeploymentService', () {
    late DeploymentService deploymentService;
    late MockHttpClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockHttpClient();
      deploymentService = DeploymentService();
    });

    test('deployToCloudflare succeeds', () async {
      when(() => mockHttpClient.post(any(), headers: any(named: 'headers'))).thenAnswer((_) async => http.Response('{}', 200));
      await deploymentService.deployToCloudflare();
      verify(() => mockHttpClient.post(any(), headers: any(named: 'headers'))).called(1);
    });

    test('deployToCloudflare fails', () async {
      when(() => mockHttpClient.post(any(), headers: any(named: 'headers'))).thenAnswer((_) async => http.Response('{}', 500));
      expect(() async => await deploymentService.deployToCloudflare(), throwsException);
    });
  });
}
