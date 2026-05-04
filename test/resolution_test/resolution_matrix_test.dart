import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';

void main() {
  group('Resolution Matrix Test', () {
    testWidgets('renders correctly on low resolution', (tester) async {
      await tester.binding.setSurfaceSize(const Size(320, 480)); // iPhone SE
      await tester.pumpWidget(const MyApp());
      expect(find.text('Rebeca\'s Creative Building'), findsOneWidget);
    });

    testWidgets('renders correctly on medium resolution', (tester) async {
      await tester.binding.setSurfaceSize(const Size(768, 1024)); // iPad
      await tester.pumpWidget(const MyApp());
      expect(find.text('Rebeca\'s Creative Building'), findsOneWidget);
    });

    testWidgets('renders correctly on high resolution', (tester) async {
      await tester.binding.setSurfaceSize(const Size(1080, 1920)); // Modern smartphone
      await tester.pumpWidget(const MyApp());
      expect(find.text('Rebeca\'s Creative Building'), findsOneWidget);
    });
  });
}
