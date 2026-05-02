import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/widgets/mouse_region_wrapper.dart';

void main() {
  testWidgets('MouseRegionWrapper test', (tester) async {
    await tester.pumpWidget(MouseRegionWrapper(child: Container()));
    // Implement test logic here
  });
}
