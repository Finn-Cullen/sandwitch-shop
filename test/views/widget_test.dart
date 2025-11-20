import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwitch_shop/main.dart';

void main() {
  testWidgets('switch toggles footlong state', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp( // provides directionality
        home: OrderScreen(),
      ),
    );

    final Finder switchFinder = find.byType(Switch);

    // initial value is true
    expect(tester.widget<Switch>(switchFinder).value, isTrue);

    await tester.tap(switchFinder);
    await tester.pump();

    expect(tester.widget<Switch>(switchFinder).value, isFalse);
  });

  testWidgets('Add to Cart shows confirmation SnackBar', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: OrderScreen(),
      ),
    );

    // Ensure the Add to Cart button is visible (scroll into view) then tap
    await tester.ensureVisible(find.text('Add to Cart'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add to Cart'));
    await tester.pump();
    await tester.pumpAndSettle();

    // SnackBar should be shown
    expect(find.byType(SnackBar), findsOneWidget);

    // The SnackBar contains a Text widget with the confirmation message
    final Finder confirmationTextFinder = find.byWidgetPredicate(
      (widget) => widget is Text && (widget.data ?? '').contains('Added 1'),
    );
    expect(confirmationTextFinder, findsOneWidget);
  });
}