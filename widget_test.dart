// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tic_tac_toe/main.dart';

void main() {
  testWidgets('Renders the home page and checks for player labels', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that the player labels are present.
    expect(find.text('Player X'), findsOneWidget);
    expect(find.text('Player O'), findsOneWidget);

    // Verify the initial scores are 0.
    expect(find.text('0'), findsNWidgets(2)); // Both scores start at 0
  });
}
