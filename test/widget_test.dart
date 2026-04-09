import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kittushealthgenie/main.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    // Build app
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );

    // Wait for UI to settle
    await tester.pumpAndSettle();

    // Verify app loaded (check main screen text)
    expect(find.text('Digital Twin'), findsOneWidget);
  });
}
