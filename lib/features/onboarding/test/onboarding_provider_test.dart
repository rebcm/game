import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/onboarding/onboarding_provider.dart';

void main() {
  test('Onboarding provider test', () async {
    final provider = OnboardingProvider();
    expect(await provider.init(), true);
  });
}
