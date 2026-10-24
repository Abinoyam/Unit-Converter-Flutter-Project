import 'package:flutter/foundation.dart';

class ConversionProvider extends ChangeNotifier {
  final List<String> _history = [];

  List<String> get history => List.unmodifiable(_history);

  void addConversion(String conversion) {
    _history.insert(0, conversion);
    notifyListeners();
  }

  void clearHistory() {
    _history.clear();
    notifyListeners();
  }
}
