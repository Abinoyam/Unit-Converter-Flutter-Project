import 'package:flutter_test/flutter_test.dart';
import 'package:unit_converter_app/main.dart';

void main() {
  testWidgets('Unit Converter home screen loads', (WidgetTester tester) async {
    await tester.pumpWidget(const UnitConverterApp());
    await tester.pumpAndSettle();

    expect(find.text('Unit Converter'), findsNWidgets(2));
    expect(find.text('Start Converting'), findsOneWidget);
  });
}
