import 'package:flutter_test/flutter_test.dart';
import 'package:stage_8_animations/main.dart';

void main() {
  testWidgets('animation experiment home screen loads', (tester) async {
    await tester.pumpWidget(const AnimationExperimentApp());
    expect(find.text('Experiment 08: Animations'), findsOneWidget);
    expect(find.text('Animated Unit Converter'), findsOneWidget);
    expect(find.text('Convert'), findsOneWidget);
  });
}
