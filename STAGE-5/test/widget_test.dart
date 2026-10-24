import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/main.dart';

void main() {
  testWidgets('Unit Converter app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const UnitConverterApp());

    await tester.pumpAndSettle();

    expect(find.text('Unit Converter'), findsOneWidget);
  });
}
