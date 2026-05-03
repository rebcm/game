import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/persistence_service.dart';
import 'package:mockito/mockito.dart';

class MockPersistenceService extends Mock implements PersistenceService {}

void main() {
  group('Slider Persistence Test', () {
    late MockPersistenceService mockPersistenceService;

    setUp(() {
      mockPersistenceService = MockPersistenceService();
    });

    testWidgets('Slider value 0% is persisted correctly', (tester) async {
      await tester.pumpWidget(MyApp());
      final slider = find.byType(Slider);
      await tester.drag(slider, Offset(-1000, 0));
      await tester.pumpAndSettle();
      verify(mockPersistenceService.saveSliderValue(0)).called(1);
    });

    testWidgets('Slider value 100% is persisted correctly', (tester) async {
      await tester.pumpWidget(MyApp());
      final slider = find.byType(Slider);
      await tester.drag(slider, Offset(1000, 0));
      await tester.pumpAndSettle();
      verify(mockPersistenceService.saveSliderValue(100)).called(1);
    });
  });
}
