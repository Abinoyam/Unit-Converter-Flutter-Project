import 'package:flutter_test/flutter_test.dart';
import 'package:stage_9_rest_api/main.dart';

void main() {
  testWidgets('REST API experiment page loads', (tester) async {
    await tester.pumpWidget(const RestApiExperimentApp());
    expect(find.text('Experiment 09: REST API'), findsOneWidget);
  });
}
