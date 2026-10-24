import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/converter_screen.dart';
import 'screens/history_screen.dart';
import 'screens/about_screen.dart';

void main() {
  runApp(const UnitConverterApp());
}

class UnitConverterApp extends StatelessWidget {
  const UnitConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Unit Converter',

      initialRoute: '/',

      routes: {
        '/': (context) => const HomeScreen(),
        '/converter': (context) => const ConverterScreen(),
        '/history': (context) => const HistoryScreen(),
        '/about': (context) => const AboutScreen(),
      },

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
    );
  }
}
