// This is a basic Flutter widget test.
//
// Use the WidgetTester utility in the flutter_test package to interact with
// widgets in your tests.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:vidyut/main.dart';

void main() {
  testWidgets('Navigation placeholder test', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const VidyutApp());

    // Verify that the Home placeholder is displayed by default.
    expect(find.text('Home'), findsWidgets);

    // Tap the Search destination and wait for navigation animation to settle.
    await tester.tap(find.byIcon(Icons.search_outlined));
    await tester.pumpAndSettle();

    // Verify that the Search placeholder is displayed.
    expect(find.text('Search'), findsWidgets);

  });
}
