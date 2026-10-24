import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stage_10_testing_debugging/main.dart';

void main() {
  testWidgets('converter screen loads and displays initial result',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TestingExperimentApp());

    expect(find.text('Experiment 10: Testing & Debugging'), findsOneWidget);
    expect(find.text('Testable Unit Converter'), findsOneWidget);
    expect(find.text('Convert'), findsOneWidget);
    expect(find.text('0.1 Kilometers'), findsOneWidget);
  });

  testWidgets('convert button updates the result', (WidgetTester tester) async {
    await tester.pumpWidget(const TestingExperimentApp());

    // Change the input from 100 to 500 meters.
    await tester.enterText(find.byKey(const Key('valueInput')), '500');

    // Tap Convert.
    await tester.tap(find.text('Convert'));
    await tester.pumpAndSettle();

    // 500 meters = 0.5 kilometers.
    expect(find.text('0.5000000 Kilometers'), findsOneWidget);
  });
}
