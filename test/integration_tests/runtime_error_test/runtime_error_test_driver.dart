import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() async {
  await integrationDriver(
    onError: (key, value) {
      print('Error occurred: $key, $value');
    },
  );
}
