import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:measures_converter/main.dart';

void main() {
  testWidgets('shows Measures Converter chrome and converts meters to feet', (
    tester,
  ) async {
    await tester.pumpWidget(const MeasuresConverterApp());

    expect(find.text('Measures Converter'), findsOneWidget);
    expect(find.text('Value'), findsOneWidget);
    expect(find.text('From'), findsOneWidget);
    expect(find.text('To'), findsOneWidget);
    expect(find.text('Convert'), findsOneWidget);

    await tester.enterText(find.byType(TextField), '100');
    await tester.tap(find.text('Convert'));
    await tester.pump();

    expect(find.text('100.0 meters are 328.084 feet'), findsOneWidget);
  });
}
