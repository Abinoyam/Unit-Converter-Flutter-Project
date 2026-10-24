# Experiment 10 — Testing & Debugging

## Aim
To test Flutter conversion logic and verify the app UI using automated tests.

## Tests included
- Unit tests for meter/kilometer/centimeter conversions and zero.
- Validation test for unsupported units.
- Widget tests for screen rendering and conversion button.
- Input validation displays a SnackBar for invalid values.

## Run tests
```bash
flutter pub get
flutter test
```

## Run app
```bash
flutter run
```

## Debugging checklist
1. Read the first error in the Debug Console/terminal.
2. Check imports and package name in `pubspec.yaml`.
3. Run `flutter pub get`.
4. Run `flutter analyze`.
5. Run `flutter test`.
6. Reproduce the issue and inspect the widget tree / console logs.

## Stage 10

This stage focuses on testing and finalizing the Flutter unit converter.

## Unit Testing

Unit tests help verify conversion logic and expected results.

## Widget Testing

Widget tests help verify Flutter interface behavior.

## Running Tests

Run the tests with flutter test from the Flutter project directory.
