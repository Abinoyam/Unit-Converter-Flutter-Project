import 'package:flutter_test/flutter_test.dart';
import 'package:stage_10_testing_debugging/main.dart';

void main() {
  group('convertLength', () {
    test('converts meters to kilometers', () {
      expect(convertLength(100, 'Meters', 'Kilometers'), closeTo(0.1, 1e-10));
    });

    test('converts kilometers to meters', () {
      expect(convertLength(1.5, 'Kilometers', 'Meters'), closeTo(1500, 1e-10));
    });

    test('converts centimeters to meters', () {
      expect(convertLength(250, 'Centimeters', 'Meters'), closeTo(2.5, 1e-10));
    });

    test('converts zero correctly', () {
      expect(convertLength(0, 'Miles', 'Meters'), 0);
    });

    test('rejects unsupported unit', () {
      expect(() => convertLength(1, 'Feet', 'Meters'), throwsArgumentError);
    });
  });
}
