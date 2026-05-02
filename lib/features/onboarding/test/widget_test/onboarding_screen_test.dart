import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/onboarding/onboarding_screen.dart';

void main() {
  testWidgets('Onboarding screen test', (tester) async {
    await tester.pumpWidget(const OnboardingScreen());
    expect(find.text('Bem-vindo ao PassDriver'), findsOneWidget);
  });
}
