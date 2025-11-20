// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwitch_shop/main.dart';

void main() {
  testWidgets('Quantity increments when add icon tapped', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: OrderScreen(),
      ),
    );

    // initial quantity is 1
    expect(find.text('1'), findsOneWidget);

    // Ensure the '+' icon is visible (scroll into view) then tap.
    await tester.ensureVisible(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our quantity has incremented to 2.
    expect(find.text('2'), findsOneWidget);
  });
}
