import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/converter_screen.dart';
import 'screens/history_screen.dart';
import 'screens/about_screen.dart';

void main() => runApp(const UnitConverterApp());

class UnitConverterApp extends StatefulWidget {
  const UnitConverterApp({super.key});

  @override
  State<UnitConverterApp> createState() => _UnitConverterAppState();
}

class _UnitConverterAppState extends State<UnitConverterApp> {
  bool _darkMode = false;
  final List<String> _history = [];

  void _toggleTheme() => setState(() => _darkMode = !_darkMode);
  void _addHistory(String item) => setState(() => _history.insert(0, item));
  void _clearHistory() => setState(() => _history.clear());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Unit Converter',
      themeMode: _darkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => HomeScreen(onToggleTheme: _toggleTheme, darkMode: _darkMode),
        '/converter': (_) => ConverterScreen(onConverted: _addHistory),
        '/history': (_) => HistoryScreen(
          history: _history,
          onClear: _clearHistory,
        ),
        '/about': (_) => const AboutScreen(),
      },
    );
  }
}
