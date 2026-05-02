import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Image Stress Test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Navigate to the screen with images
    await tester.tap(find.text('Gallery')); // Assuming there's a button/text to navigate to the gallery
    await tester.pumpAndSettle();

    // Load a large list of images
    for (int i = 0; i < 100; i++) {
      await tester.pumpWidget(MyApp(images: List.generate(100, (index) => 'assets/blocos/image_$index.png')));
      await tester.pumpAndSettle();
    }

    // Verify that the images are loaded correctly
    expect(find.byType(Image), findsWidgets);

    // Navigate away from the screen
    await tester.tap(find.text('Back')); // Assuming there's a back button
    await tester.pumpAndSettle();

    // Verify that the memory is released
    // This can be done by checking the memory usage or verifying that the images are no longer in memory
  });
}

class MyApp extends StatelessWidget {
  final List<String> images;

  const MyApp({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView.builder(
          itemCount: images.length,
          itemBuilder: (context, index) {
            return Image.asset(images[index], cacheWidth: 100, cacheHeight: 100); // Using cacheWidth and cacheHeight to optimize memory usage
          },
        ),
      ),
    );
  }
}
