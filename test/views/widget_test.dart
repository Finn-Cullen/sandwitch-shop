import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwitch_shop/main.dart';

void main() {
  testWidgets('switch state switch test', (WidgetTester tester) async {
    // Wrap your screen with MaterialApp to provide context, theme, and directionality
    await tester.pumpWidget(
      const MaterialApp( // provides directionality
        home: OrderScreen(),
      ),
    );

    expect(find.byKey(const Key('aaaaaa')), findsOneWidget);

    await tester.tap(find.byKey(const Key('aaaaaa')));
    await tester.pump();

    expect(find.text('six-inch'), findsOneWidget);
  });
  testWidgets('switch state toasted test', (WidgetTester tester) async {
    // Wrap your screen with MaterialApp to provide context, theme, and directionality
    await tester.pumpWidget(
      const MaterialApp( // provides directionality
        home: OrderScreen(),
      ),
    );

    expect(find.byKey(const Key('bbb')), findsOneWidget);

    await tester.tap(find.byKey(const Key('bbb')));
    await tester.pump();

    expect(find.text('toasted'), findsOneWidget);
  });
}